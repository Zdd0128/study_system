# Generated by Django 2.2.2 on 2021-08-16 08:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0024_auto_20210816_0830'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='is_vip',
        ),
        migrations.AlterField(
            model_name='user',
            name='email',
            field=models.CharField(max_length=32, null=True, unique=True, verbose_name='邮箱'),
        ),
    ]