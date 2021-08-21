from django.urls import path, include
from . import views
from rest_framework.routers import SimpleRouter

router = SimpleRouter()
router.register('', views.LoginView, basename='login')
router.register('', views.RegisterView, basename='register')
router.register('info', views.User_InfoView, basename='user_info')
router.register('', views.Retrieve_Pwd, basename='retrieve_pwd')
router.register('major', views.AllMajor, basename='all_major')
router.register('editor_info', views.EditorUserView, basename='editor_info')
router.register('task_record', views.TaskRecordView, basename='task_record')
router.register('paper_record', views.PaperRecordView, basename='paper_record')
router.register('wrong_que_list', views.WrongQueView, basename='wrong_que_list')
router.register('user_dynamics_list', views.UserDynamicsView, basename='user_dynamics_list')

app_name = 'student'

urlpatterns = [
    path('student/', include(router.urls)),
    path('random_num/', views.random_num),

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
