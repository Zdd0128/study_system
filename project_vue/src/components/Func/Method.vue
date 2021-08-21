<template>
    <div>
        <el-row v-if="is_method" style="margin-top: 8px">
            <h2>选择找回方式</h2>
            <el-col :span="12" :offset="6">
                <div v-if="is_email" class="div">
                    <div class="img_box">
                        <img src="../../assets/img/email.jpg" class="font_img">
                    </div>
                    <div class="text_box">
                        <h3 style="margin-left: -510px">注册邮箱</h3>
                        <span style="margin-left: -10px;font-size: 14px;">您注册的时候填写了邮箱{{is_email}},您也可以通过此方式来重置您的密码</span>
                    </div>
                    <el-button size="small" class="btn_pwd" type="primary" @click="get_email">找回密码</el-button>
                </div>

                <div v-if="is_phone" class="div">
                    <div class="img_box">
                        <img src="../../assets/img/phone.jpg" class="font_img">
                    </div>
                    <div class="text_box">
                        <h3 style="margin-left: -515px">手机短信</h3>
                        <span style="margin-left: -10px;font-size: 14px;">您的帐号已经绑定了手机{{is_phone}},可以通过发送/接受短信的方式来重置您的密码</span>
                    </div>
                    <el-button size="small" class="btn_pwd" type="primary" @click="get_phone">找回密码</el-button>
                </div>

                <div class="div">
                    <div class="img_box">
                        <img src="../../assets/img/people.jpg" class="font_img">
                    </div>
                    <div class="text_box">
                        <h3 style="margin-left: -630px">人工申诉</h3>
                        <p style="margin-left: -12px;font-size: 14px;text-align: left">
                            如果您已经无法通过其他方案找回密码，可以填写必要的帐号校验信息,我们的工作人员会在收到您的申诉请求后尽快帮您处理</p>
                    </div>
                    <el-button size="small" class="btn_pwd" type="primary" disabled>待开放</el-button>
                </div>
            </el-col>
        </el-row>

        <!--        邮箱找回密码-->
        <el-row v-if="email_pwd" style="margin-top: 33px">
            <h5>您的邮箱注册邮箱:{{is_email}}</h5>
            <el-col :span="6" :offset="9" style="margin-top: 30px">
                <el-input
                        placeholder="请输入邮箱"
                        prefix-icon="el-icon-s-comment"
                        v-model="email"
                        clearable>
                </el-input>
                <br>
                <br>
                <br>
                <el-button style="width:100%" @click="send_email_pwd" type="success">发送验证邮件
                </el-button>
            </el-col>
        </el-row>

        <!--        手机找回密码-->
        <el-row v-if="phone_pwd" style="margin-top: 33px">
            <h5>您绑定的手机:{{is_phone}}</h5>
            <el-col :span="6" :offset="9" style="margin-top: 30px">
                <el-row>
                    <el-col :span="16">
                        <el-input
                                placeholder="绑定的手机号"
                                prefix-icon="el-icon-phone"
                                v-model="phone"
                                clearable
                                @blur="check_mobile">
                        </el-input>
                    </el-col>
                    <el-col :span="8">
                        <el-button :disabled="is_click" type="success" size="medium" @click="get_phone_code">
                            {{sms_interval}}
                        </el-button>
                    </el-col>
                </el-row>
                <br>
                <br>
                <br>
                <el-input
                        placeholder="验证码"
                        prefix-icon="el-icon-s-comment"
                        v-model="code"
                        clearable>
                </el-input>
                <br>
                <br>
                <br>
                <el-button style="width:100%" @click="send_phone_pwd" type="success">验证短信</el-button>
            </el-col>
        </el-row>
    </div>
</template>

<script>

    export default {
        name: "Method",
        data() {
            return {
                is_email: false,
                is_phone: false,
                is_method: true,
                email_pwd: false,
                phone_pwd: false,
                email: '',
                phone: '',
                is_click: true,
                is_send: false,
                sms_interval: '获取验证码',
                code: '',
            }
        },
        created() {
            this.is_email = sessionStorage.email.replace(/(\w{1,3})(.+)(@.+)/g, "$1****$3")
            this.is_phone = sessionStorage.phone.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2');
        },
        methods: {
            get_email() {
                this.is_method = false;
                this.email_pwd = true
            },
            get_phone() {
                this.is_method = false;
                this.phone_pwd = true
            },

            // 发送邮件
            send_email_pwd() {
                if (!this.email) {
                    this.$message({
                        message: '邮箱不能为空!',
                        type: 'warning',
                        duration: 1500
                    });
                    return false  // 直接结束逻辑
                }
                let regEmail = /^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/
                if (!regEmail.test(this.email)) {
                    this.$message({
                        message: '邮箱格式不正确',
                        type: 'error',
                        duration: 1500
                    })
                    this.email = ''
                    return false  // 直接结束逻辑
                }
                if (this.email !== sessionStorage.email) {
                    this.$message({
                        message: '输入的邮箱和注册邮箱不匹配!',
                        type: 'error',
                        duration: 2000
                    });
                    this.email = ''
                    return false  // 直接结束逻辑
                }
                this.$emit('success',)
                this.$http({
                    url: this.$settings.base_url + '/api/student/email_pwd/',
                    method: 'post',
                    data: {
                        email: this.email
                    }
                }).then(data => {
                        if (data.data.code === 200) {
                            // console.log('111')
                            this.$cookies.set('email_token', data.data.token, 60 * 5)
                            this.$message({
                                message: data.data.msg,
                                type: 'success',
                                duration: 2000
                            });
                            this.$EventBus.$emit('email', 'email');

                        } else if (data.data.code === 999) {
                            // console.log('222')
                            this.$message({
                                message: '访问频率超过了限制,请一分钟后重试!',
                                type: 'warning',
                                duration: 1500
                            });
                            this.$router.push('/login')
                        } else {
                            // console.log('333')
                            this.$message({
                                message: data.data.msg,
                                type: 'warning',
                                duration: 1500
                            });
                        }
                    }
                )
            },

            // 校验绑定手机
            check_mobile() {
                if (this.phone !== sessionStorage.phone) {
                    this.is_click = true
                    this.$message({
                        message: '绑定手机号输入有误,请核对后重新输入!',
                        type: 'error',
                        duration: 1500
                    });
                    this.phone = ''
                    return false
                }
                this.is_click = false
                this.email = ''
            }
            ,

            // 向密保手机发送短信
            get_phone_code() {

                let sms_interval_time = 60;
                this.sms_interval = "发送中...";
                let timer = setInterval(() => {
                    if (sms_interval_time <= 1) {
                        clearInterval(timer);
                        this.sms_interval = "重新发送";
                        this.is_click = false
                    } else {
                        sms_interval_time -= 1;
                        this.sms_interval = `${sms_interval_time}秒后再发`;
                        this.is_click = true
                    }
                }, 1000);

                this.$http({
                    url: this.$settings.base_url + '/api/student/send_sms/',
                    method: 'post',
                    data: {
                        phone: this.phone
                    }
                }).then(data => {
                    if (data.data.code === 200) {
                        this.$message({
                            message: data.data.msg,
                            type: 'success',
                            duration: 1500
                        });
                    } else {
                        if (data.data.code === 999) {
                            this.$message({
                                message: '访问频率超过了限制,请一分钟后重试!',
                                type: 'error',
                                duration: 1500
                            });
                            return false
                        } else {
                            this.$message({
                                message: data.data.msg,
                                type: 'error',
                                duration: 1500
                            });
                        }
                    }
                })
            }
            ,

            // 手机验证码校验
            send_phone_pwd() {
                if (!this.code) {
                    this.$message({
                        message: '验证码不能为空!',
                        type: 'warning',
                        duration: 1500
                    });
                    return false
                }
                this.$http({
                    url: this.$settings.base_url + '/api/student/phone_code/',
                    method: 'post',
                    data: {
                        phone: this.phone,
                        code: this.code
                    }
                }).then(data => {
                    if (data.data.code === 200) {
                        this.$message({
                            message: data.data.msg,
                            type: 'success',
                            duration: 1500
                        });
                        this.$emit('success',)
                    } else {
                        this.$message({
                            message: data.data.msg,
                            type: 'error',
                            duration: 1500
                        });
                    }
                })
            },
        }
    }
</script>

<style scoped>
    .div {
        height: 120px;
        width: 770px;
        margin-bottom: 16px;
        position: reLative;
        box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04)
    }

    .img_box {
        position: absolute;
        left: 0;
        top: 10px;
    }

    .text_box {
        position: absolute;
        left: 140px;
        top: 8px;
    }

    p, span {
        color: #999999;
    }

    .font_img {
        height: 100px;
        width: 100px;
    }

    .btn_pwd {
        float: right;
    }
</style>