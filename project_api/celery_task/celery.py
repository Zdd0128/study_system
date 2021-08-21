from celery import Celery
import os

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'project_api.settings.dev')

broker = 'redis://127.0.0.1:6379/1'  # 消息中间件存放位置
backend = 'redis://127.0.0.1:6379/2'  # 结果存储位置
app = Celery('test', broker=broker, backend=backend,
             include=[
                 'celery_task.exam_task',
                 'celery_task.user_task',
             ])

# 修改时区
app.conf.timezone = 'Asia/Shanghai'  # 时区(修改时区)
app.conf.enable_utc = False  # 是否使用UTC,配合时区使用

# 任务的定时配置
from datetime import timedelta
from celery.schedules import crontab

# app.conf.beat_schedule = {
#     'add_number': {
#         'task': 'celery_task.exam_task.add',  # 要执行的任务
#         'schedule': timedelta(seconds=5),  # 每隔五秒执行一次
#         'args': (11, 22),
#     },
#     # 'add_3': {
#     #     'task': 'celery_task.home_task.add',  # 要执行的任务
#     #     'schedule': crontab(hour=8, day_of_week=1),  # 每周一早八点执行
#     #     'args': (6, 8),
#     # }
# }
