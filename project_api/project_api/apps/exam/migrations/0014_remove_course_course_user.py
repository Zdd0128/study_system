# Generated by Django 2.2.2 on 2021-08-13 00:06

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0013_auto_20210813_0001'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='course',
            name='course_user',
        ),
    ]
