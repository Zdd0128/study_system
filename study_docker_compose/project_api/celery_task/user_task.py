from .celery import app
from project_api.libs.tx_sms import send_sms
from django.conf import settings
from django.core.mail import send_mail
import base64


@app.task  # 异步发送短信
def send_sms_global(phone, code):
    res = send_sms(phone, code)

    if res:
        return '%s手机号，短信发送成功' % phone

    return '短信发送失败'


@app.task  # 异步发送邮件
def send_email(to_email):
    subject = '重置密码'  # 主题

    addr = 'http://101.91.213.1:85/Email_editor_pwd'.encode()
    addr = base64.b64encode(addr)

    # 发送的消息
    message = '请在十分钟内转到此链接修改密码!---><a href=" http://101.91.213.1:85/Email_editor_pwd">%s</a>' % addr.decode()  # 发送普通的消息使用的时候message
    
    send_mail(subject, '', settings.EMAIL_HOST_USER, (to_email,), html_message=message)
    print('异步发送邮件成功')
