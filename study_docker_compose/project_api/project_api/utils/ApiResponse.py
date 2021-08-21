from rest_framework.response import Response


class APIResponse(Response):
    def __init__(self, code=200, msg='成功', status=None, headers=None, **kwargs):
        res_data = {
            'code': code,
            'msg': msg,
        }
        if kwargs:
            res_data.update(kwargs)
        super().__init__(data=res_data, status=status, headers=headers)
