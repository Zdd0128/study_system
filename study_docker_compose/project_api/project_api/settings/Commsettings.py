# 轮播图数量
BANNER_NUM = 4

# 课程数量
COURSE_NUM = 5

# 登录用户
USER = 'user%s'

# 随机验证码
CODE_NUMBER = 'study_%s'

# 存入缓存的用户手机
SMS_CACHE = 'sms_cache_%s'

# 存入缓存的找回密码邮箱
EMAIL_CACHE = 'email_cache:%s'

# 采用安全链接
EMAIL_USE_TLS = True  # 与SMTP服务器通信时，是否启动TLS链接(安全链接)默认false
EMAIL_HOST = 'smtp.qq.com'  # SMTP地址
EMAIL_PORT = 587  # SMTP端口,本地用25,上线换587
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'  # 固定写法
EMAIL_HOST_USER = 'zqw88888888@vip.qq.com'  # 发送邮箱的邮件
EMAIL_HOST_PASSWORD = 'uatjaojnuzkgdbaj'  # 授权码
EMAIL_SUBJECT_PREFIX = '[django] '  # 为邮件Subject-line前缀,默认是'[django]'

# 轮播图接口缓存配置
BANNER_LIST = 'banner_list'

# 加盐
SALT_EMAIL = '老刘刘逼'
