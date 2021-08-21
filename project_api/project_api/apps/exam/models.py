from django.db import models
from ckeditor_uploader.fields import RichTextUploadingField  # 用于文件的上传
from django.core.cache import cache


# 用户表
class User(models.Model):
    username = models.CharField('用户名', max_length=32)
    real_name = models.CharField('真实姓名', max_length=32, default='zs')
    age = models.CharField('年龄', max_length=32, default=18)
    sex = models.CharField('性别', max_length=32, choices=(('0', '女'), ('1', '男'), ('2', '保密')), default='2')
    email = models.EmailField('邮箱', unique=True)
    phone = models.CharField('手机', max_length=32, unique=True)
    password = models.CharField('密码', max_length=32)
    avatar = models.ImageField('头像', upload_to='avatar', default='avatar/default.png', null=True)  # 必须安装pillow

    major = models.ForeignKey(to='Major', on_delete=models.DO_NOTHING, verbose_name='专业', null=True)
    create_time = models.DateTimeField('注册时间', auto_now_add=True)

    # 修改显示的表的名字
    class Meta:
        db_table = 'study_user'
        verbose_name = '用户表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

        # unique_together = ('username', 'phone', 'email')

    def __str__(self):
        return self.username

    def get_sex(self):
        return self.get_sex_display()

    def get_major(self):
        try:
            return self.major.major_name

        except:
            return '无专业'

    def college(self):

        try:
            return self.major.college.college_name

        except:
            return '无学院'


# 任务表
class Task(models.Model):
    title = models.CharField('任务标题', max_length=32, null=True)
    task_type = models.CharField('任务类型', max_length=32, choices=(('1', '每日任务'), ('2', '每周任务'), ('3', '每月任务')),
                                 null=True)
    task_time = models.CharField('任务限制时间', max_length=32, default=24)
    task_level = models.CharField('任务等级', max_length=32, choices=(('1', '简单'), ('3', '普通'), ('5', '困难')), null=True)
    task_score = models.CharField('任务分值', max_length=32, null=True)

    class Meta:
        db_table = 'study_task'
        verbose_name = '任务表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title

    def question_list(self):
        return [{'title': que.title, 'que_id': que.pk} for que in self.simple_question_set.all()]

    def type(self):
        return self.get_task_type_display()


# 任务题表
class Simple_Question(models.Model):
    title = models.CharField('简答题名称', max_length=64, null=True)
    answer = models.CharField('答案', max_length=255, null=True)

    task_score = models.CharField('任务分值', max_length=32, null=True)

    task = models.ForeignKey(to='Task', on_delete=models.DO_NOTHING, null=True)

    class Meta:
        db_table = 'study_simple_question'
        verbose_name = '简答题表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title


# 任务记录表
class Task_Record(models.Model):
    state = models.CharField('任务状态', max_length=32, choices=(('0', '待批改'), ('1', '完成')), default='0')
    create_time = models.DateTimeField('任务提交时间', auto_now_add=True)
    task_score = models.CharField('任务成绩', max_length=32, default=0)
    task = models.ForeignKey(to='Task', on_delete=models.DO_NOTHING, null=True)
    user = models.ForeignKey(to='User', on_delete=models.DO_NOTHING, null=True)

    user_task_answer = models.ManyToManyField(to='User_Task_Answer')

    # def get_user_task_answer(self):
    #     return [
    #         {'问题': obj.que.title,
    #          '用户答案': obj.user_answer}
    #         for obj in self.user_task_answer.all()
    #     ]

    # self.user_task_answer.user_task_answer.user_answer
    class Meta:
        db_table = 'study_task_record'
        verbose_name = '任务记录表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def get_state(self):
        return self.get_state_display()

    def get_task_name(self):
        return self.task.title

    def get_task_type(self):
        return self.task.get_task_type_display()


# 用户任务答案表
class User_Task_Answer(models.Model):
    user_answer = models.CharField('用户答案', max_length=255, null=True)
    que = models.ForeignKey(to='Simple_Question', on_delete=models.DO_NOTHING, null=True)

    class Meta:
        db_table = 'study_user_task_answer'
        verbose_name = '用户任务答案表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return "问题:%s;用户答案:%s;正确答案:%s;分值:%s" % (self.que.title, self.user_answer, self.que.answer, self.que.task_score)


# 试卷表
class Paper(models.Model):
    title = models.CharField('试卷标题', max_length=32, unique=True)
    time = models.IntegerField('考试时长', help_text='单位是分钟')
    paper_level = models.CharField('试卷难度', max_length=32, choices=(('1', '简单'), ('3', '普通'), ('5', '困难')), null=True)
    paper_score = models.CharField('总分', max_length=32, null=True)

    choice_question = models.ManyToManyField(to='Choice_Question')
    major = models.ForeignKey(to='Major', on_delete=models.DO_NOTHING, verbose_name='考卷适合专业')
    course = models.ForeignKey(to='Course', on_delete=models.DO_NOTHING, verbose_name='科目')

    class Meta:
        db_table = 'study_paper'
        verbose_name = '试卷表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title

    def get_course(self):
        return self.course.course_name

    def get_all_question_bank(self):
        return [{'id': que.pk, 'title': que.title, 'A': que.a, 'B': que.b, 'C': que.c, 'D': que.d, 'answer': que.answer,
                 'score': que.score} for que in self.choice_question.all()]


# 试卷题表
class Choice_Question(models.Model):
    # 富文本编辑器
    title = RichTextUploadingField(
        default='',
        verbose_name='题目名称',
    )
    a = models.CharField(max_length=32, verbose_name='A选项')
    b = models.CharField(max_length=32, verbose_name='B选项')
    c = models.CharField(max_length=32, verbose_name='c选项')
    d = models.CharField(max_length=32, verbose_name='D选项')

    answer = models.CharField(
        max_length=32,
        choices=(('A', 'A'), ('B', 'B'), ('C', 'C'), ('D', 'D')),
        verbose_name='答案'
    )
    score = models.CharField(max_length=32, verbose_name='分值')

    class Meta:
        db_table = 'study_choice_question'
        verbose_name = '单选题表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name


# 试卷记录表
class Paper_Record(models.Model):
    state = models.CharField('试卷状态', max_length=32, choices=(('0', '待批改'), ('1', '完成')), default='0')
    create_time = models.DateTimeField('试卷提交时间', auto_now_add=True)
    paper_score = models.CharField('试卷成绩', max_length=32, default=0)
    paper = models.ForeignKey(to='Paper', verbose_name="试卷类型", on_delete=models.DO_NOTHING, null=True)
    user = models.ForeignKey(to='User', verbose_name="提交用户", on_delete=models.DO_NOTHING, null=True)

    class Meta:
        db_table = 'study_paper_record'
        verbose_name = '试卷记录表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def get_state(self):
        return self.get_state_display()

    def get_paper_name(self):
        return self.paper.title

    def get_paper_type(self):
        return self.paper.major.major_name

    # 错题本字段
    # def que_detail(self):
    #     # models.
    #     return [{} for que in self.paper_record]


# 用户试卷答案表
class User_Paper_Answer(models.Model):
    user_answer = models.CharField('用户答案', max_length=255, null=True)
    que = models.ForeignKey(to='Choice_Question', db_constraint=False, on_delete=models.DO_NOTHING, null=True)
    paper_record = models.ForeignKey(to='Paper_Record', on_delete=models.DO_NOTHING, null=True)
    is_true = models.BooleanField('是否正确', default=False)
    user = models.ForeignKey(to="User", on_delete=models.DO_NOTHING, null=True)

    class Meta:
        db_table = 'study_user_paper_answer'
        verbose_name = '用户试卷答案'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def que_detail(self):
        return {
            'title': self.que.title,
            'user_answer': self.user_answer,
            'show_answer': self.que.answer,
            'A': self.que.a,
            'B': self.que.b,
            'C': self.que.c,
            'D': self.que.d,
            'level': self.paper_record.paper.paper_level,
            'score': self.que.score,
            'analysis': '题目解析...',
        }

    def que_course(self):
        return self.paper_record.paper.course.course_name

    def que_title(self):
        return self.que.title

    def que_type(self):
        return '单选题'

    def que_time(self):
        return self.paper_record.create_time

    def que_user_answer(self):
        return self.user_answer


##############################
# 轮播图表
class Banner(models.Model):
    title = models.CharField(max_length=32, unique=True, verbose_name='名称')
    image = models.ImageField(upload_to='banner', verbose_name='图片', help_text='必须传入图片大小为 3840*800')
    link = models.CharField(max_length=64, verbose_name='跳转链接')
    info = models.TextField(verbose_name='详情')  # 也可以用详情表，宽高出处

    class Meta:
        db_table = 'study_banner'
        verbose_name = '轮播图表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title


# 用户动态记录表
class DynamicMessage(models.Model):
    create_time = models.DateTimeField('动态产生时间', auto_now_add=True)
    message = models.CharField('消息内容', max_length=64)

    user = models.ForeignKey(to='User', on_delete=models.DO_NOTHING)

    class Meta:
        db_table = 'study_dynamic_message'
        verbose_name = '用户动态表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def get_user(self):
        return self.user.username


# 用户成绩表
# class Record(models.Model):
#     grade = models.CharField('成绩', max_length=10)
#
#     student = models.ForeignKey(to='Student', on_delete=models.DO_NOTHING, verbose_name='学生ID')
#     course = models.ForeignKey(to='Course', on_delete=models.DO_NOTHING, verbose_name='科目')
#
#     class Meta:
#         db_table = 'study_user_record'
#         verbose_name = '用户成绩表'  # 后台admin中显示的名字
#         verbose_name_plural = verbose_name


# 学院表
class College(models.Model):
    college_name = models.CharField('学院名称', max_length=32)
    college_addr = models.CharField('学院地址', max_length=32)

    class Meta:
        db_table = 'study_college'
        verbose_name = '学院表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.college_name


# 专业表
class Major(models.Model):
    major_name = models.CharField('专业名称', max_length=32)

    college = models.ForeignKey(to='College', on_delete=models.DO_NOTHING, verbose_name='学院')

    class Meta:
        db_table = 'study_major'
        verbose_name = '专业表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.major_name


# 课程表
class Course(models.Model):
    course_name = models.CharField('课程名称', max_length=32, null=True)
    course_price = models.CharField('课程价格', max_length=32, null=True)
    course_img = models.ImageField('封面图片', upload_to='course_img', default='course_img/default.png')
    course_brief = models.TextField("详情介绍", max_length=2048, null=True, blank=True)
    course_pub_date = models.DateField("发布日期", auto_now_add=True, null=True)
    course_students = models.IntegerField("学习人数", default=0, null=True)
    course_sections = models.IntegerField("总章节", default=0, null=True)

    major = models.ForeignKey(to='Major', on_delete=models.DO_NOTHING, null=True)

    class Meta:
        db_table = 'study_course'
        verbose_name = '课程表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.course_name

    def is_buy(self):
        return [{'is_buy': obj.order_status} for obj in self.order_set.all().filter(user_id=cache.get(''))]

    def course_chapter_list(self):
        return [{'chapter_name': obj.chapter_name, 'chapter_link': obj.chapter_link, 'chapter_time': obj.chapter_time}
                for obj in self.coursechapter_set.all()]


# 章节表
class CourseChapter(models.Model):
    chapter_name = models.CharField('章节名称', max_length=32, null=True)
    chapter_link = models.CharField('章节链接', max_length=255, null=True)
    chapter_time = models.CharField('章节时长', max_length=64, null=True)

    course = models.ForeignKey(to='Course', on_delete=models.CASCADE)

    class Meta:
        db_table = 'study_course_chapter'
        verbose_name = '章节表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.chapter_name


# 订单表
class Order(models.Model):
    status_choices = (
        (0, '未支付'),
        (1, '已支付'),
        (2, '已取消'),
        (3, '超时取消'),
    )
    pay_choices = (
        (1, '支付宝'),
        (2, '微信支付'),
    )
    subject = models.CharField("订单标题", max_length=150)
    total_amount = models.DecimalField("订单总价", max_digits=10, decimal_places=2, default=0)
    out_trade_no = models.CharField("订单号", max_length=64, unique=True)  # 必须唯一
    trade_no = models.CharField("流水号", max_length=64, null=True)
    order_status = models.SmallIntegerField("订单状态", choices=status_choices, default=0)
    pay_type = models.SmallIntegerField("支付方式", choices=pay_choices, default=1)
    pay_time = models.DateTimeField("支付时间", null=True)
    created_time = models.DateTimeField('创建时间', auto_now_add=True)

    user = models.ForeignKey(User, related_name='order_user', on_delete=models.DO_NOTHING)
    course = models.ForeignKey(Course, on_delete=models.DO_NOTHING, null=True)

    class Meta:
        db_table = "study_order"
        verbose_name = "订单记录"
        verbose_name_plural = "订单记录"

    def __str__(self):
        return "%s - ￥%s" % (self.subject, self.total_amount)


# 订单详情表
class OrderDetail(models.Model):
    price = models.DecimalField("课程价格", max_digits=10, decimal_places=2)

    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)

    class Meta:
        db_table = "study_order_detail"
        verbose_name = "订单详情"
        verbose_name_plural = "订单详情"

    def __str__(self):
        try:
            return "%s的订单：%s" % (self.course.course_name, self.order.out_trade_no)
        except:
            return super().__str__()


# 电影表
class Movies(models.Model):
    movie_title = models.CharField('电影标题', max_length=32)
    movie_link = models.CharField('电影链接', max_length=255, null=True)
    movie_time = models.CharField('电影时长', max_length=64, null=True)
    movie_img = models.CharField('电影封面', max_length=32, null=True)

    class Meta:
        db_table = 'study_movies'
        verbose_name = '电影表'  # 后台admin中显示的名字
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.movie_title
