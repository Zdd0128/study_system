from qcloudsms_py import SmsSingleSender
from . import settings
import random


def get_code():
    code = ''
    for i in range(5):
        msg = random.randrange(0, 9)
        code += str(msg)

    return code


def send_sms(phone, code):
    ssender = SmsSingleSender(settings.APPID, settings.APPKEY)
    params = [code, '5']  # 当模板没有参数时，`params = []`
    try:
        result = ssender.send_with_param(86, phone, settings.TEMPLATE_ID, params, sign=settings.SMS_SIGN,
                                         extend="", ext="")

        if result.get('result') == 0:
            return True

    except Exception as e:
        return False
