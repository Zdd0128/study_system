# Generated by Django 2.2.2 on 2021-08-09 23:17

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='paper_record',
            old_name='task_score',
            new_name='paper_score',
        ),
    ]
