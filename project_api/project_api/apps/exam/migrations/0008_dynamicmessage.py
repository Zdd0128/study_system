# Generated by Django 2.2.2 on 2021-08-11 17:31

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0007_auto_20210810_2232'),
    ]

    operations = [
        migrations.CreateModel(
            name='DynamicMessage',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='动态产生时间')),
                ('message', models.CharField(max_length=64, verbose_name='消息内容')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='exam.User')),
            ],
            options={
                'verbose_name': '用户动态表',
                'verbose_name_plural': '用户动态表',
                'db_table': 'study_dynamic_message',
            },
        ),
    ]
