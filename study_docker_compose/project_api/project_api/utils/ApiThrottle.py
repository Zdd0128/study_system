from rest_framework.throttling import SimpleRateThrottle


class PhoneThrottle(SimpleRateThrottle):
    scope = 'phone'  # 一定要写

    def get_cache_key(self, request, view):
        # 返回谁，就以谁做限制

        return request.data.get('phone')
