from rest_framework.viewsets import ViewSetMixin
from rest_framework.generics import ListAPIView
from utils.ApiResponse import APIResponse
from django.core.cache import cache
from django.conf import settings


# 装饰器实现轮播图接口缓存
def outer(func):
    def inner(self, request, *args, **kwargs):
        response = cache.get(self.cache_field % request.user)
        if response:
            print('走缓存')
            return APIResponse(result=response)
        res = func(self, request, *args, **kwargs)
        print('走数据库')
        cache.set(self.cache_field % request.user, res.data['result'], 300)

        return res

    return inner


class CommonListView(ViewSetMixin, ListAPIView):
    # 加上装饰器加入缓存,反之
    @outer
    def list(self, request, *args, **kwargs):
        response = super().list(request, *args, **kwargs)
        return APIResponse(result=response.data)


# 轮播图接口加入缓存
class CacheCommonListView(ViewSetMixin, ListAPIView):

    def list(self, request, *args, **kwargs):
        response = cache.get(settings.BANNER_LIST)
        if response:
            return APIResponse(result=response)

        response = super().list(request, *args, **kwargs)
        cache.set(settings.BANNER_LIST, response.data, 600)
        return APIResponse(result=response.data)
