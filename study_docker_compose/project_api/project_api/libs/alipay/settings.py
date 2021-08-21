import os

# 应用私钥
APP_PRIVATE_KEY_STRING = open(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pem', 'app_private_key.pem')).read()

# 支付宝公钥
ALIPAY_PUBLIC_KEY_STRING = open(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pem', 'alipay_public_key.pem')).read()

# 应用ID
APP_ID = '2021000117697872'

# 加密方式
SIGN = 'RSA2'

# 是否是支付宝测试环境(沙箱环境)，如果采用真是支付宝环境，配置False
DEBUG = True

# 支付网关
GATEWAY = 'https://openapi.alipaydev.com/gateway.do?' if DEBUG else 'https://openapi.alipay.com/gateway.do'

# 上线后必须换成公网地址
# 后台基URL
BASE_URL = 'http://101.91.213.1:8188'
# 前台基URL
PROJECT_URL = 'http://101.91.213.1:85'
# 支付宝同步异步回调接口配置
# 后台异步回调接口
NOTIFY_URL = BASE_URL + "/api/exam/success/"
# 前台同步回调接口，没有 / 结尾
RETURN_URL = PROJECT_URL + "/pay/success/"
