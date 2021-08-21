from rest_framework import serializers
from rest_framework_jwt.settings import api_settings
from exam import models
from rest_framework.exceptions import AuthenticationFailed
from django.core.cache import cache
from django.conf import settings

jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER

import re
import hashlib
import itsdangerous

from rest_framework_jwt.utils import jwt_encode_handler


# 密码加密加盐
def _get_md5(res):
    obj = hashlib.md5()
    obj.update('天王'.encode('utf-8'))
    obj.update(res.encode('utf-8'))
    obj.update('盖地虎'.encode('utf-8'))
    return obj.hexdigest()


# 轮播图
class BannerSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Banner
        fields = '__all__'


# 注册校验
class CreateStudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.User
        fields = ('username', 'password', 'email', 'phone')

    def validate_username(self, username):
        user = models.User.objects.filter(username=username).first()
        if not user:
            return username
        raise AuthenticationFailed('当前用户已存在')

    def validate_password(self, password):
        password = _get_md5(password)
        return password

    def validate(self, attrs):
        if not re.match(r'^.+@.+$', attrs.get('email')):
            raise AuthenticationFailed('邮箱不符合规范')

        elif not re.match(r'^1[3-9][0-9]{9}$', attrs.get('phone')):
            raise AuthenticationFailed('手机号不符合规范')

        return attrs

    def create(self, validated_data):
        user = models.User.objects.create(**validated_data)
        models.DynamicMessage.objects.create(user=user, message='%s成功注册了学无止境学习系统!' % user.username)
        return user


# 用户名密码登录校验
class StudentSerializer(serializers.ModelSerializer):
    username = serializers.CharField()

    class Meta:
        model = models.User
        fields = ('username', 'password')

    def validate(self, attrs):
        user = self._get_user(attrs)

        payload = jwt_payload_handler(user)
        token = jwt_encode_handler(payload)

        self.context['token'] = token
        self.context['username'] = user.username
        self.context['avatar'] = str(user.avatar)
        self.context['user_id'] = user.pk

        cache.set(settings.USER % user.id, user, 604800)

        return attrs

    def _get_user(self, attrs):
        username = attrs.get('username')
        password = _get_md5(attrs.get('password'))

        if re.match(r'^1[3-9][0-9]{9}$', username):
            user = models.User.objects.filter(phone=username).first()

        elif re.match(r'^.+@.+$', username):
            user = models.User.objects.filter(email=username).first()

        else:
            user = models.User.objects.filter(username=username).first()

        if user:
            if user.password == password:
                models.DynamicMessage.objects.create(user=user, message='%s使用账号登录学无止境学习系统!' % user.username)
                return user

            raise AuthenticationFailed('用户名或密码错误!')

        raise AuthenticationFailed('当前用户不存在')


# 手机短信登录校验
class StudentPhoneSerializer(serializers.Serializer):
    phone = serializers.CharField()
    code = serializers.CharField()

    def validate(self, attrs):
        _check_code(attrs)

        user = models.User.objects.filter(phone=attrs.get('phone')).first()

        if not user:
            raise AuthenticationFailed('当前手机号不存在!')

        payload = jwt_payload_handler(user)
        token = jwt_encode_handler(payload)

        self.context['token'] = token
        self.context['username'] = user.username
        self.context['avatar'] = str(user.avatar)
        self.context['user_id'] = user.pk

        cache.set(settings.USER % user.id, user, 604800)
        models.DynamicMessage.objects.create(user=user, message='%s使用手机登录学无止境学习系统!' % user.username)

        return attrs


# 用户个人信息序列化和反序列化类
class User_Info_Serializer(serializers.ModelSerializer):
    # email = serializers.CharField()
    # phone = serializers.CharField()

    class Meta:
        model = models.User
        fields = (
            'username',
            'real_name',
            'age',
            'email',
            'sex',
            'phone',
            'get_sex',
            'get_major',
            'create_time',
            'major',
            'college'
        )
        extra_kwargs = {
            'create_time': {'read_only': True},
            'username': {'read_only': True},
            'get_sex': {'read_only': True},
            'get_major': {'read_only': True},
            'college': {'read_only': True},
            'sex': {'write_only': True},
            'major': {'write_only': True},
        }

    def validate(self, attrs):
        # print(attrs)
        email = attrs.get('email')
        phone = attrs.get('phone')
        if not email:
            raise AuthenticationFailed('邮箱不能为空!')

        elif not phone:
            raise AuthenticationFailed('手机号不能能为空!')

        # email_user = models.User.objects.filter(email=email).first()
        # if email_user:
        #     raise AuthenticationFailed('当前邮箱已存在')
        # phone_user = models.User.objects.filter(phone=phone).first()
        #
        # if phone_user:
        #     raise AuthenticationFailed('当前手机号已存在')

        if not re.match(r'^.+@.+$', attrs.get('email')):
            raise AuthenticationFailed('邮箱不符合规范')

        elif not re.match(r'^1[3-9][0-9]{9}$', attrs.get('phone')):
            raise AuthenticationFailed('手机号不符合规范')

        models.DynamicMessage.objects.create(
            user_id=self.context.get('request').user['id'],
            message='%s修改个人信息!' % self.context.get('request').user['username'])

        return attrs


# 个人动态序列化
class User_Dynamics_Serializer(serializers.ModelSerializer):
    class Meta:
        model = models.DynamicMessage
        fields = (
            'create_time',
            'message',
            'get_user',
        )


# 校验缓存中的验证码是否有效
def _check_code(attrs):
    code = attrs.get('code')
    phone = attrs.get('phone')
    # 获取放在缓存中的code
    old_code = cache.get(settings.SMS_CACHE % phone)
    print('用户验证码:%s' % code)
    print('缓存验证码:%s' % old_code)
    # 删除缓存中的code
    cache.delete(settings.SMS_CACHE % phone)
    if not (old_code and code == old_code):
        raise AuthenticationFailed('校验失败')


# 验证码校验
class UserPhoneSerializer(serializers.ModelSerializer):
    phone = serializers.CharField()
    # code不是User表的字段，所以要重写
    code = serializers.CharField()

    class Meta:
        model = models.User
        fields = ['phone', 'code']

    def validate(self, attrs):
        # 校验code是否正确
        _check_code(attrs)

        return attrs


# 邮箱保存密码反序列化校验
class EmailPwdSerializer(serializers.ModelSerializer):
    token = serializers.CharField()
    new_password = serializers.CharField()
    re_password = serializers.CharField()

    class Meta:
        model = models.User
        fields = ('new_password', 're_password', 'token')

    def validate(self, attrs):
        token = attrs.get('token')
        email = self._decrypt_token(token)
        if not email:
            raise AuthenticationFailed('校验错误,修改密码失败!')

        # 校验code是否正确
        show = self._check_email(email)
        if not show:
            raise AuthenticationFailed('邮箱校验失败!')

        new_password = attrs.get('new_password')
        re_password = attrs.get('re_password')

        if not new_password == re_password:
            raise AuthenticationFailed('两次密码输入不一致！')

        password = _get_md5(new_password)
        user = models.User.objects.filter(email=email).first()
        user.password = password
        user.save()

        models.DynamicMessage.objects.create(user=user, message='%s通过邮箱成功找回了密码!' % user.username)

        return attrs

    # 反解token,校验邮箱是否合法
    def _decrypt_token(self, token):
        t = itsdangerous.TimedJSONWebSignatureSerializer(settings.SALT_EMAIL, expires_in=300)  # 过期时间600秒
        res = t.loads(token)
        return res['email']

    # 校验缓存中的邮箱是否有效
    def _check_email(self, email):
        cache_email = cache.get(settings.EMAIL_CACHE % email)
        if email == cache_email:
            return True

        return False


# 手机找回密码
class RetrievePwdSerializer(serializers.ModelSerializer):
    re_pwd = serializers.CharField()
    phone = serializers.CharField()

    class Meta:
        model = models.User
        fields = ('phone', 'password', 're_pwd')

    def validate(self, attrs):
        password = attrs.get('password')
        re_pwd = attrs.get('re_pwd')

        if not password == re_pwd:
            raise AuthenticationFailed('两次密码输入不一致！')
        password = _get_md5(password)

        user = models.User.objects.filter(phone=attrs.get('phone')).first()
        user.password = password
        user.save()

        models.DynamicMessage.objects.create(user=user, message='%s通过手机成功找回了密码!' % user.username)

        return attrs


# 所有课程
class All_MajorSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Major
        fields = '__all__'
