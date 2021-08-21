<template>
    <div class="pay-success">
        <!--如果是单独的页面，就没必要展示导航栏(带有登录的用户)-->
        <Header/>
        <div class="main" style="margin-top: 40px">
            <div class="title">
                <div class="success-tips">
                    <p class="tips">您已成功购买 1 门课程！</p>
                </div>
            </div>
            <div class="order-info">
                <p class="info"><b>订单号：</b><span>{{ result.out_trade_no }}</span></p>
                <p class="info"><b>交易号：</b><span>{{ result.trade_no }}</span></p>
                <p class="info"><b>付款时间：</b><span><span>{{ result.timestamp }}</span></span></p>
            </div>
            <div class="study">
                <span @click="go_study">立即学习</span>
            </div>
        </div>
    </div>
</template>

<script>
    import Header from "../../components/Home/Header"

    export default {
        name: "index",
        data() {
            return {
                url: '',
                error: '',
                result: {},
            };
        },
        created() {
            // url后拼接的参数：?及后面的所有参数 => ?a=1&b=2
            // console.log(location.search);

            // 解析支付宝回调的url参数
            let params = location.search.substring(1);  // 去除? => a=1&b=2
            let items = params.length ? params.split('&') : [];  // ['a=1', 'b=2']
            //逐个将每一项添加到args对象中
            for (let i = 0; i < items.length; i++) {  // 第一次循环a=1，第二次b=2
                let k_v = items[i].split('=');  // ['a', '1']
                //解码操作，因为查询字符串经过编码的
                if (k_v.length >= 2) {
                    // url编码反解
                    let k = decodeURIComponent(k_v[0]);
                    this.result[k] = decodeURIComponent(k_v[1]);
                    // 没有url编码反解
                    // this.result[k_v[0]] = k_v[1];
                }
            }
            // 解析后的结果
            // console.log(this.result);

            // 把地址栏上面的支付结果，再get请求转发给后端
            this.$http({
                // url: 'http://110.40.189.224:8001' + '/api/exam/success/' + location.search,
                // url: 'http://101.91.213.1:8001' + '/api/exam/success/' + location.search,
                url: this.$settings.base_url + '/api/exam/success/' + location.search,
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(date => {
                if (date.data.code === 200) {
                    this.url = '/home/video/course_detail/1'
                } else {
                    this.error = date.data.msg
                }
            })
        },
        methods: {
            go_study() {
                if (this.url) {
                    this.$router.push(this.url)
                } else {
                    this.$message({
                        message: this.error,
                        type: 'error',
                        duration: 1500
                    });
                }
            }
        },
        components: {
            Header,
        }
    }
</script>

<style scoped>
    .main {
        padding: 60px 0;
        margin: 0 auto;
        width: 1200px;
        background: #fff;
    }

    .main .title {
        display: flex;
        -ms-flex-align: center;
        align-items: center;
        padding: 25px 40px;
        border-bottom: 1px solid #f2f2f2;
    }

    .main .title .success-tips {
        box-sizing: border-box;
    }

    .title img {
        vertical-align: middle;
        width: 60px;
        height: 60px;
        margin-right: 40px;
    }

    .title .success-tips {
        box-sizing: border-box;
    }

    .title .tips {
        font-size: 26px;
        color: #000;
    }


    .info span {
        color: #ec6730;
    }

    .order-info {
        padding: 25px 48px;
        padding-bottom: 15px;
        border-bottom: 1px solid #f2f2f2;
    }

    .order-info p {
        display: -ms-flexbox;
        display: flex;
        margin-bottom: 10px;
        font-size: 16px;
    }

    .order-info p b {
        font-weight: 400;
        color: #9d9d9d;
        white-space: nowrap;
    }

    .study {
        padding: 25px 40px;
    }

    .study span {
        display: block;
        width: 140px;
        height: 42px;
        text-align: center;
        line-height: 42px;
        cursor: pointer;
        background: #ffc210;
        border-radius: 6px;
        font-size: 16px;
        color: #fff;
    }
</style>