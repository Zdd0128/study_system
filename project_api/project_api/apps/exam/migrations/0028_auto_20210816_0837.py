# Generated by Django 2.2.2 on 2021-08-16 08:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0027_auto_20210816_0833'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_vip',
            field=models.BooleanField(default=False, verbose_name='是否会员'),
        ),
        migrations.AlterField(
            model_name='user',
            name='email',
            field=models.EmailField(max_length=254, null=True, unique=True, verbose_name='邮箱'),
        ),
        migrations.AlterField(
            model_name='user',
            name='password',
            field=models.CharField(max_length=32, verbose_name='密码'),
        ),
        migrations.AlterField(
            model_name='user',
            name='real_name',
            field=models.CharField(default='张三', max_length=32, unique=True, verbose_name='真实姓名'),
        ),
    ]
