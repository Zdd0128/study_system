from exam import models
from rest_framework.viewsets import ViewSetMixin
from rest_framework.generics import ListAPIView, CreateAPIView, RetrieveAPIView
from utils import ApiSerializer
from utils.exam import ExamSerializer
from settings import dev
from utils.views import CommonListView, CacheCommonListView
from utils.ApiResponse import APIResponse
from celery_task.exam_task import correcting_test_papers
from rest_framework.views import APIView
from rest_framework.response import Response
from utils.ApiLogging import logger
from django_filters.rest_framework import DjangoFilterBackend


# # 轮播图接口(无缓存)
# class BannerView(CommonListView):
#     queryset = models.Banner.objects.all()[:dev.BANNER_NUM]
#     serializer_class = ApiSerializer.BannerSerializer

# 轮播图接口(有缓存)
class BannerView(CacheCommonListView):
    queryset = models.Banner.objects.all()[:dev.BANNER_NUM]
    serializer_class = ApiSerializer.BannerSerializer
    authentication_classes = []


# 每日任务接口
class DayTaskView(CommonListView):
    queryset = models.Task.objects.all()
    serializer_class = ExamSerializer.DayTaskSerializer
    cache_field = 'day_task:%s'


# 基础试卷接口
class ExamPaperView(CommonListView):
    queryset = models.Paper.objects.all()
    serializer_class = ExamSerializer.ExamPaperSerializer
    cache_field = 'exam_paper:%s'


# 用户提交任务接口
class UserTakeTaskView(ViewSetMixin, CreateAPIView):
    queryset = models.User_Task_Answer
    serializer_class = ExamSerializer.UserTaskSerializer

    def create(self, request, *args, **kwargs):
        obj = models.Task_Record.objects.create(
            task_id=request.query_params.get('task_id'),
            user_id=request.query_params.get('user_id')
        )

        models.DynamicMessage.objects.create(
            user_id=request.query_params.get('user_id'),
            message='%s提交了每日任务!' % request.user['username']
        )

        ser = self.get_serializer(data=request.data, many=True, context={'obj': obj.pk})
        if ser.is_valid():
            self.perform_create(ser)

            return APIResponse()
        return APIResponse(msg=ser.errors)


# 用户提交试卷接口
class UserPaperView(ViewSetMixin, CreateAPIView):
    queryset = models.User_Paper_Answer
    serializer_class = ExamSerializer.UserPaperSerializer

    def create(self, request, *args, **kwargs):
        obj = models.Paper_Record.objects.create(
            paper_id=request.query_params.get('paper_id'),
            user_id=request.query_params.get('user_id')
        )

        ser = self.get_serializer(data=request.data, many=True,
                                  context={'obj': obj.pk, 'user_id': request.query_params.get('user_id')})
        if ser.is_valid():
            self.perform_create(ser)

            correcting_test_papers.delay(obj.pk, request.user['username'])
            # correcting_test_papers(obj.pk)

            return APIResponse()
        return APIResponse()


# 课程接口
class CourseView(ViewSetMixin, ListAPIView):
    queryset = models.Course.objects.all()
    serializer_class = ExamSerializer.CourseSerializer

# 已解锁课程接口
class UnlockCourseView(ViewSetMixin, ListAPIView):
    queryset = models.Order.objects.all()
    serializer_class = ExamSerializer.UnlockCourseSerializer

    filter_backends = [DjangoFilterBackend, ]
    filter_fields = ('user_id', 'order_status')


# 校验课程是否购买
class CourseIsBuyView(ViewSetMixin, ListAPIView):
    queryset = models.Order.objects.all()
    serializer_class = ExamSerializer.CourseIsBuySerializer

    filter_backends = [DjangoFilterBackend, ]
    filter_fields = ('user_id', 'course_id')


# 购买课程接口
class PayCourseView(ViewSetMixin, CreateAPIView):
    queryset = models.Order.objects.all()
    serializer_class = ExamSerializer.PayCourseSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data, context={'request': request})
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        pay_url = serializer.context.get('pay_url')

        return APIResponse(pay_url=pay_url)


# # 验证课程是否解锁
# class CourseIsBuyView(CommonListView):
#     queryset = models.Order.objects.all()
#     serializer_class = ExamSerializer.CourseIsBuySerializer


# 支付宝回调接口
class SuccessView(APIView):
    def get(self, request):
        print('前端get回调')
        # vue的前端来调用的
        out_trade_no = request.query_params.get('out_trade_no')
        order = models.Order.objects.filter(out_trade_no=out_trade_no).first()
        if order.order_status == 1:
            # 订单支付成功，
            return APIResponse(msg='支付成功')

        return APIResponse(code=201, msg='我们还没有收到该订单的付款，请稍后刷新页面再试')

    def post(self, request):
        print('支付宝post回调')
        # 支付宝来调用，用来修改订单状态
        import json
        try:
            result_data = request.data.dict()  # 把querydict转成字典对象，否则，不允许改值
            logger.warning(json.dumps(result_data))
            out_trade_no = result_data.get('out_trade_no')
            signature = result_data.pop('sign')
            # 一定要验证签名，如果不验证签名，不能修改订单状态
            from project_api.libs.alipay import alipay
            result = alipay.verify(result_data, signature)
            if result and result_data["trade_status"] in ("TRADE_SUCCESS", "TRADE_FINISHED"):
                # 完成订单修改：订单状态、流水号、支付时间
                models.Order.objects.filter(out_trade_no=out_trade_no).update(order_status=1)

                # 记录用户动态
                models.DynamicMessage.objects.create(message='%s用户购买Python课程成功!', user_id=request.user['user_id'])

                # 完成日志记录
                logger.warning('%s订单支付成功' % out_trade_no)
                return Response('success')  # 支付宝要求的格式
            else:
                logger.error('%s订单支付失败' % out_trade_no)

        except:
            pass
        return Response('failed')


# 课程详情接口
class CourseDetailView(ViewSetMixin, RetrieveAPIView):
    queryset = models.Course.objects.all()
    serializer_class = ExamSerializer.CourseDetailSerializer

    def retrieve(self, request, *args, **kwargs):
        response = super().retrieve(request, *args, **kwargs)
        return APIResponse(result=response.data)


# 电影信息接口
class MoviesListView(CommonListView):
    queryset = models.Movies.objects.all()
    serializer_class = ExamSerializer.Movies_List_Serializer
    cache_field = 'movies_list:%s'
