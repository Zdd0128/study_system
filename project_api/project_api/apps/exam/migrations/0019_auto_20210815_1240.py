# Generated by Django 2.2.2 on 2021-08-15 12:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0018_coursechapter_chapter_time'),
    ]

    operations = [
        migrations.CreateModel(
            name='Movies',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('movie_title', models.CharField(max_length=32, verbose_name='电影标题')),
                ('movie_link', models.CharField(max_length=255, null=True, verbose_name='电影链接')),
                ('movie_time', models.CharField(max_length=64, null=True, verbose_name='电影时长')),
            ],
            options={
                'verbose_name': '电影表',
                'verbose_name_plural': '电影表',
                'db_table': 'study_movies',
            },
        ),
        migrations.DeleteModel(
            name='Teacher',
        ),
    ]
