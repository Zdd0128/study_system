from django.urls import path, include
from . import views
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
router.register('banner', views.BannerView, basename='banner')
router.register('course', views.CourseView, basename='course')
router.register('course_buy', views.UnlockCourseView, basename='course_buy')
router.register('day_task', views.DayTaskView, basename='day_task')
router.register('save_task', views.UserTakeTaskView, basename='save_task')
router.register('exam_paper', views.ExamPaperView, basename='exam_paper')
router.register('save_paper', views.UserPaperView, basename='save_paper')
router.register('course_is_buy', views.CourseIsBuyView, basename='course_is_buy')
router.register('pay_course', views.PayCourseView, basename='pay_course')
router.register('course_video_detail', views.CourseDetailView, basename='course_video_detail')
router.register('movie_list', views.MoviesListView, basename='movie_list')



app_name = 'exam'

urlpatterns = [
    path('exam/', include(router.urls)),
    path('exam/success/', views.SuccessView.as_view()),

    # path('stulogout/',views.stulogout,name='stulogout'), # 学生退出登录
    # path('tealogout/',views.tealogout,name='tealogout'), # 学生退出登录
    # path('emailsend/',views.email_send,name='emailsend'),  # 发送验证码
    # path('sendemail/',views.send_my_email,name='sendemail'),  # 发送验证码
    # path('studentLogin/',views.studentLogin,name='studentLogin'),   # 学生登录
    # path('teacherLogin/',views.teacherLogin,name='teacherLogin'),   # 老师登录
    # path('startExam/',views.startExam,name='startExam'),  # 开始考试
    # path('calculateGrade/',views.calculateGrade,name='calculateGrade'),  # 交卷计算成绩
    # path('showGrade/',views.showGrade,name='showGrade'),  # 成绩统计
]
