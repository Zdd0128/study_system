from project_api.utils.ApiLogging import logger
from rest_framework.views import exception_handler
from rest_framework.response import Response


def common_exception_handler(exc, context):
    # 只要出异常,为异常记录日志
    logger.error('ip为%s的用户，访问%s视图类出错,错误信息是%s' % (
        context.get('request').META.get('REMOTE_ADDR'), str(context.get('view')), str(exc)))
    response = exception_handler(exc, context)
    if response:
        # drf的异常
        print('drf异常')
        print(response.data.get('detail'))
        return Response({'code': 999, 'msg': response.data.get('detail', '服务器异常,请联系系统管理员')})

    # django的异常
    print('django异常')
    print(exc)
    return Response({'code': 444, 'msg': '服务器异常，请联系系统管理员'})
