# Generated by Django 2.2.2 on 2021-08-10 08:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0002_auto_20210809_2317'),
    ]

    operations = [
        migrations.AddField(
            model_name='user_paper_answer',
            name='is_true',
            field=models.BooleanField(default=False, verbose_name='是否正确'),
        ),
    ]
