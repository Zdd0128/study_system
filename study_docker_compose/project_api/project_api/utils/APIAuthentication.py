from rest_framework_jwt.authentication import BaseAuthentication
from rest_framework.exceptions import AuthenticationFailed
import jwt
from rest_framework_jwt.settings import api_settings
from exam.models import User

# 第三方模块rest_framework_jwt提供的解码方法,传入token返回荷载payload
jwt_decode_handler = api_settings.JWT_DECODE_HANDLER
jwt_get_username_from_payload = api_settings.JWT_PAYLOAD_GET_USERNAME_HANDLER


class MyAuthentication(BaseAuthentication):

    def authenticate(self, request):
        token = request.META.get('HTTP_TOKEN')

        if token:
            try:
                payload = jwt_decode_handler(token)
            except jwt.ExpiredSignature:
                raise AuthenticationFailed('token已经过期')

            except jwt.DecodeError:
                raise AuthenticationFailed('token认证失败')

            except jwt.InvalidTokenError:
                raise AuthenticationFailed('token不合法')
        else:
            raise AuthenticationFailed('请求中缺少参数tokne')

        # user = self.authenticate_credentials(payload)
        # user=User.objects.get(pk=payload.get('user_id'))
        # 优化,减少数据库压力
        # user = User(id=payload.get('user_id'), username=payload.get('username'))
        user = {'id': payload.get('user_id'), 'username': payload.get('username')}

        return (user, token)

    def authenticate_credentials(self, payload):

        user = User.objects.get(username=payload['username'])

        return user
