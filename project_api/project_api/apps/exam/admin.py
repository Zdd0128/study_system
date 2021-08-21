from openpyxl import Workbook
from django.http import HttpResponse
from .models import Banner, College, Major, Course, User, Choice_Question, Paper, Simple_Question, Task, Task_Record, \
    CourseChapter,Movies,Order,OrderDetail
from django.contrib import admin

admin.site.register(Course)
admin.site.register(CourseChapter)
admin.site.register(Movies)
admin.site.register(Order)
admin.site.register(OrderDetail)


# 增加导出excle功能
class ExportExcelMixin(object):
    def export_as_excel(self, request, queryset):
        meta = self.model._meta  # 用于定义文件名, 格式为: app名.模型类名
        field_names = [field.name for field in meta.fields]  # 模型所有字段名

        response = HttpResponse(content_type='application/msexcel')  # 定义响应内容类型
        response['Content-Disposition'] = f'attachment; filename={meta}.xlsx'  # 定义响应数据格式
        wb = Workbook()  # 新建Workbook
        ws = wb.active  # 使用当前活动的Sheet表
        ws.append(field_names)  # 将模型字段名作为标题写入第一行
        for obj in queryset:  # 遍历选择的对象列表
            for field in field_names:
                data = [f'{getattr(obj, field)}' for field in field_names]  # 将模型属性值的文本格式组成列表
            row = ws.append(data)  # 写入模型属性值
        wb.save(response)  # 将数据存入响应内容
        return response

    export_as_excel.short_description = '导出Excel'


@admin.register(Banner)
class BannerAdmin(admin.ModelAdmin):
    # 展示那些字段
    list_display = ('id', 'title', 'link')


# 学院信息
@admin.register(College)
class AcademyAdmin(admin.ModelAdmin):
    list_display = ("id", "college_name", "college_addr")
    # 按照学号降序排列
    ordering = ("id",)


# 专业信息
@admin.register(Major)
class SpecialityAdmin(admin.ModelAdmin):
    list_display = ("id", "major_name", "college")
    ordering = ("id",)


# 将模型注册到admin中
@admin.register(User)
class UserAdmin(admin.ModelAdmin, ExportExcelMixin):
    # 显示出来的信息
    list_display = ("id", "username", "age", "sex", "email", "phone", 'major')
    # 根据学号和姓名查找
    search_fields = ('id', 'username')
    # 过滤器  根据下列的选项去过滤
    list_filter = ("username", "sex", "major")
    # 按照学号降序排列
    ordering = ("id",)
    # 分页
    list_per_page = 10
    actions = ["export_as_excel", ]


# 单选题表
@admin.register(Choice_Question)
class Choice_QuestionAdmin(admin.ModelAdmin, ExportExcelMixin):
    list_display = ("id", "title", "a", "b", "c", "d", "answer", "score")
    # 根据科目 专业去搜索
    search_fields = ("id", "title")
    # 过滤器  根据题科目的名称  以及专业的名称  题目名称
    list_filter = ("title",)
    # 按照序号排列
    ordering = ("id",)
    list_per_page = 10
    actions = ["export_as_excel", ]


# 试卷
@admin.register(Paper)
class PaperAdmin(admin.ModelAdmin, ExportExcelMixin):
    def show_question(self, obj):
        return [exam.title for exam in obj.question_bank.all()]

    list_display = ("id", "title", "time", "major", 'course')
    # 根据科目 专业去搜索
    search_fields = ("id", "major", "course")
    # 过滤器  根据题科目的名称  以及专业的名称  题目名称
    list_filter = ("id", "major", "course")
    # 按照序号排列
    list_per_page = 10
    ordering = ['id']
    actions = ["export_as_excel", ]


# 简答题表
@admin.register(Simple_Question)
class Simple_QuestionAdmin(admin.ModelAdmin, ExportExcelMixin):
    list_display = ("id", "title", "answer")


# 任务表
@admin.register(Task)
class TaskAdmin(admin.ModelAdmin, ExportExcelMixin):
    list_display = ("id", "title", "task_type", "task_level", "task_score")


# 任务记录表
@admin.register(Task_Record)
class Task_RecordAdmin(admin.ModelAdmin, ExportExcelMixin):
    def que_number(self, obj):
        num = len(obj.user_task_answer.all())
        return num

    list_display = ("state", "create_time", "task_score", "user", "task", "que_number")


# 站点名称
admin.site.site_header = '学无止境'

# 网页标题
admin.site.site_title = '学习系统'
