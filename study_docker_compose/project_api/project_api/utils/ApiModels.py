# 创建一个基表（后期，轮播图，课程表，都要继承这个基表）
# 这个表不希望在数据库生成

from django.db import models


class BaseModel(models.Model):
    created_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_time = models.DateTimeField(auto_now=True, verbose_name='最后更新时间')
    is_delete = models.BooleanField(default=False, verbose_name='是否删除')
    is_show = models.BooleanField(default=True, verbose_name='是否上架')
    orders = models.IntegerField(verbose_name='优先级')

    class Meta:
        abstract = True  # 不在数据库生成该表，只用来做继承
