# Generated by Django 2.2.2 on 2021-08-13 00:01

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0012_order_orderdetail'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='order_user', to='exam.User'),
        ),
        migrations.AlterField(
            model_name='orderdetail',
            name='course',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='exam.Course'),
        ),
        migrations.AlterField(
            model_name='orderdetail',
            name='order',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='exam.Order'),
        ),
        migrations.AlterField(
            model_name='orderdetail',
            name='price',
            field=models.DecimalField(decimal_places=2, max_digits=10, verbose_name='课程价格'),
        ),
    ]