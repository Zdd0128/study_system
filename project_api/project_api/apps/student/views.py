from django.shortcuts import HttpResponse
from utils import ApiSerializer
from rest_framework.generics import RetrieveAPIView, ListAPIView, UpdateAPIView
from rest_framework.viewsets import ViewSet, ViewSetMixin
from rest_framework.decorators import action
from utils.ApiResponse import APIResponse
from exam.models import User, Major, Task_Record, Paper_Record, User_Paper_Answer, DynamicMessage
from PIL import Image, ImageDraw, ImageFont
from io import BytesIO
import random
from project_api.libs.tx_sms import get_code
from django.core.cache import cache
from django.conf import settings
from rest_framework.exceptions import AuthenticationFailed
from utils.ApiLogging import logger
from rest_framework.throttling import AnonRateThrottle
from utils.ApiThrottle import PhoneThrottle
import itsdangerous
from celery_task.user_task import send_sms_global, send_email
import os
from django_filters.rest_framework import DjangoFilterBackend
from utils.exam import ExamSerializer
from utils.exam.NumberPagination import CommonPageNumberPagination, CommonPageNumberPagination1
from rest_framework.filters import OrderingFilter
from utils.views import CommonListView


# from celery_task.exam_task import add


# 登陆接口
class LoginView(ViewSet):
    authentication_classes = []

    # 用户名密码登录
    @action(methods=['POST'], detail=False)
    def login(self, request):
        ser = ApiSerializer.StudentSerializer(data=request.data)

        ser.is_valid(raise_exception=True)
        token = ser.context.get('token')
        username = ser.context.get('username')
        avatar = ser.context.get('avatar')
        user_id = ser.context.get('user_id')

        return APIResponse(
            msg='登录成功',
            result={
                'username': username,
                'token': token,
                'avatar': avatar,
                'user_id': user_id,
            }
        )

    # 手机短信登录
    @action(methods=['POST'], detail=False)
    def login_phone(self, request):
        ser = ApiSerializer.StudentPhoneSerializer(data=request.data)
        ser.is_valid(raise_exception=True)
        token = ser.context.get('token')
        username = ser.context.get('username')
        avatar = ser.context.get('avatar')
        user_id = ser.context.get('user_id')

        return APIResponse(
            msg='登录成功',
            result={
                'username': username,
                'token': token,
                'avatar': avatar,
                'user_id': user_id,
            }
        )


# 注册接口
class RegisterView(ViewSet):
    authentication_classes = []

    @action(methods=['POST'], detail=False)
    def register(self, request):
        ser = ApiSerializer.CreateStudentSerializer(data=request.data)

        if ser.is_valid():
            ser.save()

            return APIResponse(msg='注册成功')

        return APIResponse(code=201, msg=ser.errors)


# 所有专业接口
class AllMajor(ViewSetMixin, ListAPIView):
    queryset = Major.objects.all()
    serializer_class = ApiSerializer.All_MajorSerializer


# 个人信息接口
class User_InfoView(ViewSetMixin, RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = ApiSerializer.User_Info_Serializer


# 个人动态接口
class UserDynamicsView(CommonListView):
    queryset = DynamicMessage.objects.all()
    serializer_class = ApiSerializer.User_Dynamics_Serializer
    cache_field = 'user_dynamics_list:%s'

    filter_backends = [DjangoFilterBackend, ]

    # 过滤
    filter_fields = ('user_id',)


# 个人信息编辑
class EditorUserView(ViewSetMixin, UpdateAPIView):
    queryset = User.objects.all()
    serializer_class = ApiSerializer.User_Info_Serializer

    # 个人头像修改
    @action(methods=['POST'], detail=False)
    def editor_avatar(self, request):
        file_obj = request.FILES.get('file')

        path = os.path.join(os.path.dirname(settings.BASE_DIR), 'media', 'avatar')

        if not os.path.exists(path):
            os.mkdir(path)

        file_path = os.path.join(path, file_obj.name)

        with open(file_path, 'ab') as f:
            [f.write(line) for line in file_obj.chunks()]

        user = cache.get(settings.USER % request.user['id'])
        print(user.pk)
        print(request.user['id'])

        user_obj = User.objects.filter(pk=user.pk).first()
        user_obj.avatar = 'avatar/' + file_obj.name
        user_obj.save()

        # DynamicMessage.objects.create(user=user, message='%s修改头像!' % user.username)

        return APIResponse(msg='头像修改成功,刷新生效', avatar=str(user_obj.avatar))

    def update(self, request, *args, **kwargs):

        # request.data['major'] = request.data['major']
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        ser = self.get_serializer(instance, data=request.data, partial=partial, context={'request': request})
        if ser.is_valid():
            self.perform_update(ser)

            return APIResponse(msg='修改成功!')
        return APIResponse(code=201, msg=ser.errors)


# 个人任务记录接口
class TaskRecordView(ViewSetMixin, ListAPIView):
    queryset = Task_Record.objects.all()
    serializer_class = ExamSerializer.User_Task_serializer
    filter_backends = [DjangoFilterBackend, ]

    # 过滤
    filter_fields = ('user_id',)

    # 分页
    pagination_class = CommonPageNumberPagination1


# 个人试卷记录接口
class PaperRecordView(ViewSetMixin, ListAPIView):
    queryset = Paper_Record.objects.all()
    serializer_class = ExamSerializer.User_Paper_serializer
    filter_backends = [DjangoFilterBackend, ]

    # 过滤
    filter_fields = ('user_id',)

    # 分页
    pagination_class = CommonPageNumberPagination


# 个人错题本展示
class WrongQueView(ViewSetMixin, ListAPIView):
    queryset = User_Paper_Answer.objects.all().filter(is_true=False)
    serializer_class = ExamSerializer.WrongQueSerializer
    cache_field = 'wrong_que_list:%s'

    filter_backends = [DjangoFilterBackend, ]

    filter_fields = ('user_id',)

    # 分页
    pagination_class = CommonPageNumberPagination


# 随机验证码
def get_random():
    return random.randint(0, 255), random.randint(0, 255), random.randint(0, 255)


# 验证码实时展示
def random_num(request):
    img_obj = Image.new('RGB', (170, 40), 'white')
    img_draw = ImageDraw.Draw(img_obj)
    img_font = ImageFont.truetype('media/font/111.ttf', 40)

    code = ''
    for i in range(4):
        random_int = str(random.randint(0, 9))
        random_lower = chr(random.randint(65, 90))
        random_upper = chr(random.randint(97, 122))
        tmp = random.choice([random_int, random_lower, random_upper])
        img_draw.text((42 * i + 10, 0), tmp, get_random(), img_font)
        code += tmp

    # dev.CODE_NUMBER = code
    cache.set(settings.CODE_NUMBER % code, code, 300)

    io_obj = BytesIO()

    img_obj.save(io_obj, 'png')

    return HttpResponse(io_obj.getvalue())


# 找回密码接口
class Retrieve_Pwd(ViewSet):
    authentication_classes = []

    # 验证账号是否存在
    @action(methods=['POST'], detail=False, throttle_classes=[AnonRateThrottle])
    def find_account(self, request):
        username = request.data.get('username')
        code = request.data.get('code')
        # code_num = dev.CODE_NUMBER
        code_num = cache.get(settings.CODE_NUMBER % code)

        if code:
            if code_num:
                # if code.upper():
                user = User.objects.filter(username=username).first()

                if user:
                    return APIResponse(
                        msg='请求成功',
                        result={
                            'email': user.email,
                            'phone': user.phone,
                            'username': user.username
                        }
                    )

                return APIResponse(code=201, msg='当前用户不存在')

            return APIResponse(code=202, msg='验证码不正确')

        return APIResponse(code=203, msg='验证码不能为空')

    # 发送邮箱接口
    @action(methods=['POST'], detail=False, throttle_classes=[AnonRateThrottle])
    def email_pwd(self, request):
        email = request.data.get('email')

        t = itsdangerous.TimedJSONWebSignatureSerializer(settings.SALT_EMAIL, expires_in=300)  # 过期时间600秒
        info = {'email': email}
        res = t.dumps(info)
        token = res.decode()  # 指定编码格式

        # send_email.delay(email)
        send_email(email)

        # 将当前找回密码用户邮箱存进cache,方便校验
        cache.set(settings.EMAIL_CACHE % email, email, 300)

        return APIResponse(msg='发送成功,请前往邮箱查看!(有效时间5分钟!)', token=token)

        # # 获取短信验证码(同步)
        # @action(methods=['POST'], detail=False, throttle_classes=[PhoneThrottle])
        # def send_sms(self, request):
        #     phone = request.data.get('phone')
        #     if phone:
        #         code = tx_sms.get_code()
        #         print(code)
        #         # 发送短信
        #         msg = tx_sms.send_sms(phone, code)
        #         if msg:
        #             cache.set(settings.SMS_CACHE % phone, code, 600)
        #
        #             return APIResponse(msg='短信发送成功!')
        #
        #         logger.error('手机号为:%s,发送短信失败!' % phone)
        #
        #         raise AuthenticationFailed('短信发送失败!')
        #
        #     raise AuthenticationFailed('手机号没有传!')

        # # 延迟任务演示
        # @action(methods=['POST'], detail=False, throttle_classes=[PhoneThrottle])
        # def send_sms(self, request):
        #     phone = request.data.get('phone')
        #     if phone:
        #         code = get_code()
        #         print(code)
        #         # 异步发送短信
        #         from datetime import datetime, timedelta
        #         # 当前utc时间,往后推10s
        #         eta = datetime.utcnow() + timedelta(seconds=20)  # 时间对象计算
        #
        #         # args是列表，send_sms的参数，eta是延迟时间，时间对象
        #         res = add.apply_async(args=[888, 999], eta=eta)
        #         print(res)
        #
        #         return APIResponse(msg='短信发送成功,请注意查收!')
        #
        #     raise AuthenticationFailed('手机号没有传!')

        # 获取短信验证码(异步)

    # 邮箱保存密码
    @action(methods=['POST'], detail=False)
    def email_save_pwd(self, request):
        if not request.data.get('new_password'):
            return APIResponse(code=201, msg='新密码不能为空')

        elif not request.data.get('re_password'):
            return APIResponse(code=201, msg='确认密码不饿能为空')

        elif not request.data.get('token'):
            return APIResponse(code=201, msg='超过有效时间,请稍后重试!')

        ser = ApiSerializer.EmailPwdSerializer(data=request.data)

        ser.is_valid(raise_exception=True)

        return APIResponse(msg='邮箱找回密码成功,请重新登录！')

    # 发送验证码接口
    @action(methods=['POST'], detail=False, throttle_classes=[PhoneThrottle])
    def send_sms(self, request):
        phone = request.data.get('phone')
        if phone:
            code = get_code()
            # print(code)
            # 异步发送短信
            send_sms_global.delay(phone, code)
            cache.set(settings.SMS_CACHE % phone, code, 300)

            return APIResponse(msg='短信发送成功,请注意查收!(五分钟内有效)')

        raise AuthenticationFailed('手机号没有传!')

    # 手机验证码找回密码
    @action(methods=['POST'], detail=False)
    def phone_code(self, request):
        ser = ApiSerializer.UserPhoneSerializer(data=request.data)
        ser.is_valid(raise_exception=True)
        return APIResponse(msg='验证成功')

    # 手机找回密码
    @action(methods=['POST'], detail=False)
    def phone_pwd(self, request):
        ser = ApiSerializer.RetrievePwdSerializer(data=request.data)
        ser.is_valid(raise_exception=True)

        return APIResponse(msg='手机找回密码成功,请重新登录！')
