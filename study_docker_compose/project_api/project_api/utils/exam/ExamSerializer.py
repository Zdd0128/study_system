from rest_framework import serializers
from rest_framework_jwt.settings import api_settings
from exam import models
from rest_framework.exceptions import AuthenticationFailed
from django.core.cache import cache
from django.conf import settings
from project_api.libs.alipay import alipay, gateway
from uuid import uuid4


# 用户任务中心序列化类
class DayTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Task
        fields = (
            'id',
            'title',
            'type',
            'task_type',
            'task_time',
            'task_level',
            'task_score',
            'question_list',
        )


# 用户任务答案反序列化类
class UserTaskSerializer(serializers.ModelSerializer):
    que_id = serializers.IntegerField()

    class Meta:
        model = models.User_Task_Answer
        fields = ('que_id', 'user_answer')

    def validate(self, attrs):
        answer_list = attrs.get('user_answer')

        if len(answer_list) == 0:
            raise AuthenticationFailed('题目答案不能为空!')

        return attrs

    def create(self, validated_data):
        # record_obj = models.Task_Record.objects.filter(pk=self.context.get('obj')).first()

        obj = models.User_Task_Answer.objects.create(**validated_data)
        obj.task_record_set.add(self.context.get('obj'))

        return obj


# 用户任务记录序列化类
class User_Task_serializer(serializers.ModelSerializer):
    class Meta:
        model = models.Task_Record
        fields = (
            'id',
            'task_score',
            'create_time',
            'get_state',
            'get_task_name',
            'get_task_type'
        )


###########################################################

# 用户试卷序列化类
class ExamPaperSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Paper
        fields = (
            'id',
            'title',
            'time',
            'paper_level',
            'paper_score',
            'get_course',
            'get_all_question_bank',
        )


# 用户试卷答案反序列化类
class UserPaperSerializer(serializers.ModelSerializer):
    que_id = serializers.IntegerField()

    class Meta:
        model = models.User_Paper_Answer
        fields = ('que_id', 'user_answer')

    def validate(self, attrs):
        answer_list = attrs.get('user_answer')
        if len(answer_list) == 0:
            raise AuthenticationFailed('题目答案不能为空!')

        return attrs

    def create(self, validated_data):
        validated_data['paper_record_id'] = self.context.get('obj')
        validated_data['user_id'] = self.context.get('user_id')

        validated_data['que_id'] = int(validated_data['que_id'])

        obj = models.User_Paper_Answer.objects.create(**validated_data)

        return obj


# 用户试卷记录序列化类
class User_Paper_serializer(serializers.ModelSerializer):
    class Meta:
        model = models.Paper_Record
        fields = (
            'id',
            'paper_score',
            'create_time',
            'get_state',
            'get_paper_name',
            'get_paper_type'
        )


# 用户错题展示序列化类
class WrongQueSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User_Paper_Answer
        fields = (
            'que_detail',
            'que_user_answer',
            'que_course',
            'que_time',
            'que_title',
            'que_type'
        )


# 验证课程是否解锁序列化类
class CourseIsBuySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Order
        fields = ('order_status',)


# 已解锁课程序列化类
class UnlockCourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Order
        fields = ('course_id',)


# 课程详情
class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Course
        fields = (
            'id',
            'course_students',
            'course_sections',
            'course_price',
            'course_name',
            'course_img',
            'course_brief',
            # 'is_buy',
        )


# 购买课程序列化类
class PayCourseSerializer(serializers.ModelSerializer):
    # courses=serializers.ListField()  # 映射列表形式
    # courses=serializers.DictField()  # 映射字典形式

    # 这个字段，会把前端传入的课程id列表，转换成课程对象列表
    courses = serializers.PrimaryKeyRelatedField(queryset=models.Course.objects.all(), many=True)

    class Meta:
        model = models.Order
        fields = ('total_amount', 'courses')

    def validate(self, attrs):
        '''
            1.校验课程总价格
            2.获取当前登录用户
            3.生成支付连接
            4.存库之前数据处理
            5.生成订单（存order和orderdetail表）
        '''

        # 校验课程价格
        self._contrast_course_price(attrs)

        # 获取购买用户
        user_id = self._get_user()

        # 生成支付订单号
        trade_no = self._get_out_trade_no()  # 获取商品订单号
        total_amount = float(attrs.get('total_amount'))

        # 订单名：如果是一个课程，就使用课程名，如果是多个课程，就使用第一个课程名+等
        if len(attrs.get('courses')) > 1:
            subject = '合并支付'
        else:
            subject = attrs.get('courses')[0].course_name
        pay_url = self._get_pay_url(total_amount, subject, trade_no)
        self.context['pay_url'] = pay_url

        # 支付前数据处理
        course_id = attrs.get('courses')[0].pk
        self._perform_save(attrs, user_id, trade_no, subject, course_id)

        return attrs

    def create(self, validated_data):
        courses = validated_data.pop('courses')
        order = models.Order.objects.create(**validated_data)
        # 存订单详情
        for course in courses:
            models.OrderDetail.objects.create(order=order, course=course, price=float(course.course_price))
        return validated_data

    def _get_user(self):

        return self.context.get('request').user['id']

    def _contrast_course_price(self, attrs):
        total_amount = attrs.get('total_amount')
        courses = attrs.get('courses')
        price = 0
        for course in courses:
            price += int(course.course_price)
        if total_amount != price:
            raise AuthenticationFailed('价格不匹配')
        if int(total_amount) == 0:
            raise AuthenticationFailed('商品价格不能为0!')

    def _get_out_trade_no(self):
        # 使用uuid生成
        # 分布式id生成方案（在分布式的节点中生成不重复的id号，性能高）
        #   -uuid
        #   -mysql 自增   当前时间+自增
        #   -redis自增    当前时间+incr
        #   -雪花算法      主流
        #   -美团的Leaf
        return str(uuid4()).replace('-', '')

    def _perform_save(self, attrs, user, trade_no, subject, course_id):
        # 把当前登录用户放到attrs中，把订单号，放入attrs中
        attrs['user_id'] = user
        attrs['out_trade_no'] = trade_no
        attrs['subject'] = subject
        attrs['course_id'] = course_id

    def _get_pay_url(self, total_amount, subject, trade_no):
        from project_api.libs.alipay import settings
        res = alipay.api_alipay_trade_page_pay(
            # subject=trade_name + '1课程',
            subject=subject,
            total_amount=total_amount,
            out_trade_no=trade_no,
            return_url=settings.RETURN_URL,  # 前端回调地址
            notify_url=settings.NOTIFY_URL  # 后端回调地址
        )
        return gateway + res


# 课程详情序列化类
class CourseDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Course
        fields = (
            'course_name',
            'course_brief',
            'course_pub_date',
            'course_students',
            'course_sections',
            'course_chapter_list',
        )


# 电影信息序列化类
class Movies_List_Serializer(serializers.ModelSerializer):
    class Meta:
        model = models.Movies
        fields = '__all__'
