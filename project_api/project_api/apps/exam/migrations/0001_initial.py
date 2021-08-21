# Generated by Django 2.2.2 on 2021-08-09 21:55

import ckeditor_uploader.fields
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Banner',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=32, unique=True, verbose_name='名称')),
                ('image', models.ImageField(help_text='必须传入图片大小为 3840*800', upload_to='banner', verbose_name='图片')),
                ('link', models.CharField(max_length=64, verbose_name='跳转链接')),
                ('info', models.TextField(verbose_name='详情')),
            ],
            options={
                'verbose_name': '轮播图表',
                'verbose_name_plural': '轮播图表',
                'db_table': 'study_banner',
            },
        ),
        migrations.CreateModel(
            name='Choice_Question',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', ckeditor_uploader.fields.RichTextUploadingField(default='', verbose_name='题目名称')),
                ('a', models.CharField(max_length=32, verbose_name='A选项')),
                ('b', models.CharField(max_length=32, verbose_name='B选项')),
                ('c', models.CharField(max_length=32, verbose_name='c选项')),
                ('d', models.CharField(max_length=32, verbose_name='D选项')),
                ('answer', models.CharField(choices=[('A', 'A'), ('B', 'B'), ('C', 'C'), ('D', 'D')], max_length=32, verbose_name='答案')),
                ('score', models.CharField(max_length=32, verbose_name='分值')),
            ],
            options={
                'verbose_name': '单选题表',
                'verbose_name_plural': '单选题表',
                'db_table': 'study_choice_question',
            },
        ),
        migrations.CreateModel(
            name='College',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('college_name', models.CharField(max_length=32, verbose_name='学院名称')),
                ('college_addr', models.CharField(max_length=32, verbose_name='学院地址')),
            ],
            options={
                'verbose_name': '学院表',
                'verbose_name_plural': '学院表',
                'db_table': 'study_college',
            },
        ),
        migrations.CreateModel(
            name='Course',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('course_name', models.CharField(max_length=32, verbose_name='课程名称')),
                ('course_price', models.CharField(default=18888, max_length=32, verbose_name='课程价格')),
                ('course_img', models.ImageField(default='course_img/default.png', upload_to='course_img', verbose_name='图片')),
            ],
            options={
                'verbose_name': '课程表',
                'verbose_name_plural': '课程表',
                'db_table': 'study_course',
            },
        ),
        migrations.CreateModel(
            name='Major',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('major_name', models.CharField(max_length=32, verbose_name='专业名称')),
                ('college', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='exam.College', verbose_name='学院')),
            ],
            options={
                'verbose_name': '专业表',
                'verbose_name_plural': '专业表',
                'db_table': 'study_major',
            },
        ),
        migrations.CreateModel(
            name='Paper',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=32, unique=True, verbose_name='试卷标题')),
                ('time', models.IntegerField(help_text='单位是分钟', verbose_name='考试时长')),
                ('paper_level', models.CharField(choices=[('1', '简单'), ('3', '普通'), ('5', '困难')], max_length=32, null=True, verbose_name='试卷难度')),
                ('paper_score', models.CharField(max_length=32, null=True, verbose_name='总分')),
                ('choice_question', models.ManyToManyField(to='exam.Choice_Question')),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Course', verbose_name='科目')),
                ('major', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Major', verbose_name='考卷适合专业')),
            ],
            options={
                'verbose_name': '试卷表',
                'verbose_name_plural': '试卷表',
                'db_table': 'study_paper',
            },
        ),
        migrations.CreateModel(
            name='Paper_Record',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('state', models.CharField(choices=[('0', '待批改'), ('1', '完成')], default='0', max_length=32, verbose_name='试卷状态')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='试卷提交时间')),
                ('task_score', models.CharField(default=0, max_length=32, verbose_name='试卷成绩')),
                ('paper', models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Paper')),
            ],
            options={
                'verbose_name': '试卷记录表',
                'verbose_name_plural': '试卷记录表',
                'db_table': 'study_paper_record',
            },
        ),
        migrations.CreateModel(
            name='Simple_Question',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=64, null=True, verbose_name='简答题名称')),
                ('answer', models.CharField(max_length=255, null=True, verbose_name='答案')),
            ],
            options={
                'verbose_name': '简答题表',
                'verbose_name_plural': '简答题表',
                'db_table': 'study_simple_question',
            },
        ),
        migrations.CreateModel(
            name='Task',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=32, null=True, verbose_name='任务标题')),
                ('task_type', models.CharField(choices=[('1', '每日任务'), ('2', '每周任务'), ('3', '每月任务')], max_length=32, null=True, verbose_name='任务类型')),
                ('task_time', models.CharField(default=24, max_length=32, verbose_name='任务限制时间')),
                ('task_level', models.CharField(choices=[('1', '简单'), ('3', '普通'), ('5', '困难')], max_length=32, null=True, verbose_name='任务等级')),
                ('task_score', models.CharField(max_length=32, null=True, verbose_name='任务分值')),
            ],
            options={
                'verbose_name': '任务表',
                'verbose_name_plural': '任务表',
                'db_table': 'study_task',
            },
        ),
        migrations.CreateModel(
            name='Task_Record',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('state', models.CharField(choices=[('0', '待批改'), ('1', '完成')], default='0', max_length=32, verbose_name='任务状态')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='任务提交时间')),
                ('task_score', models.CharField(default=0, max_length=32, verbose_name='任务成绩')),
                ('task', models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Task')),
            ],
            options={
                'verbose_name': '任务记录表',
                'verbose_name_plural': '任务记录表',
                'db_table': 'study_task_record',
            },
        ),
        migrations.CreateModel(
            name='User_Task_Answer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_answer', models.CharField(max_length=255, null=True, verbose_name='用户答案')),
                ('que', models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Simple_Question')),
                ('task_record', models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Task_Record')),
            ],
            options={
                'verbose_name': '用户任务答案表',
                'verbose_name_plural': '用户任务答案表',
                'db_table': 'study_user_task_answer',
            },
        ),
        migrations.CreateModel(
            name='User_Paper_Answer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_answer', models.CharField(max_length=255, null=True, verbose_name='用户答案')),
                ('paper_record', models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Paper_Record')),
                ('que', models.ForeignKey(db_constraint=False, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Choice_Question')),
            ],
            options={
                'verbose_name': '用户试卷答案',
                'verbose_name_plural': '用户试卷答案',
                'db_table': 'study_user_paper_answer',
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=32, verbose_name='用户名')),
                ('real_name', models.CharField(default='张三', max_length=32, verbose_name='真实姓名')),
                ('age', models.CharField(default=18, max_length=32, verbose_name='年龄')),
                ('sex', models.CharField(choices=[('0', '女'), ('1', '男'), ('2', '保密')], default='2', max_length=32, verbose_name='性别')),
                ('email', models.EmailField(max_length=254, null=True, verbose_name='邮箱')),
                ('phone', models.CharField(max_length=32, unique=True, verbose_name='手机')),
                ('password', models.CharField(max_length=32, verbose_name='密码')),
                ('avatar', models.ImageField(default='avatar/default.png', null=True, upload_to='avatar', verbose_name='头像')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='注册时间')),
                ('major', models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Major', verbose_name='专业')),
            ],
            options={
                'verbose_name': '用户表',
                'verbose_name_plural': '用户表',
                'db_table': 'study_user',
                'unique_together': {('username', 'phone', 'email')},
            },
        ),
        migrations.AddField(
            model_name='task_record',
            name='user',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.User'),
        ),
        migrations.AddField(
            model_name='simple_question',
            name='task',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Task'),
        ),
        migrations.AddField(
            model_name='paper_record',
            name='user',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.User'),
        ),
        migrations.AddField(
            model_name='course',
            name='major',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.DO_NOTHING, to='exam.Major', verbose_name='专业'),
        ),
    ]
