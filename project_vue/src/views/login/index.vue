<template>
    <div class="login">
        <div class="box">
            <div class="lowin-brand">
                <img src="../../assets/Logo.png" alt="logo" style="width: 100%;margin-top: 12px">
            </div>
            <p style="color:rgb(63,200,240);font-size: 16px;font-weight: 600">学无止境</p>
            <div class="content">
                <div class="nav">
                    <span :class="{active: login_method === 'is_pwd'}"
                          @click="change_login_method('is_pwd')">密码登录</span>
                    <span :class="{active: login_method === 'is_sms'}"
                          @click="change_login_method('is_sms')">短信登录</span>
                </div>

                <el-form v-if="login_method === 'is_pwd'">
                    <el-input
                            placeholder="用户名/手机号/邮箱"
                            prefix-icon="el-icon-user"
                            v-model="username"
                            clearable>
                    </el-input>
                    <el-input
                            placeholder="密码"
                            prefix-icon="el-icon-key"
                            v-model="password"
                            clearable
                            show-password>
                    </el-input>
                    <el-button type="primary" @click="login">登录</el-button>
                </el-form>

                <el-form v-if="login_method === 'is_sms'">
                    <el-input
                            placeholder="手机号"
                            prefix-icon="el-icon-phone-outline"
                            v-model="phone"
                            clearable>
                    </el-input>
                    <el-input
                            placeholder="验证码"
                            prefix-icon="el-icon-chat-line-round"
                            v-model="code"
                            clearable>
                        <template slot="append">
                            <span class="sms" @click="send_sms">{{ sms_interval }}</span>
                        </template>
                    </el-input>
                    <el-button @click="phone_login" type="primary">登录</el-button>
                </el-form>

                <div class="foot">
                    <span @click="go_register">没有账号? 立即注册</span>
                    <span @click="retrieve_pwd" class="retrieve_pwd"
                          style="font-size: 13px;margin-right: 86px;margin-top:16px;color: #999999">忘记密码?</span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Login",
        data() {
            return {
                username: '',
                password: '',
                user: '',
                phone: '',
                code_phone: '',
                code: '',
                login_method: 'is_pwd',
                sms_interval: '获取验证码',
                is_send: false,
                is_click: false,
                dialogVisible: false,
            }
        },
        methods: {
            close_login() {
                this.$emit('close')
            },
            go_register() {
                this.$router.push('/register')
            },
            change_login_method(method) {
                this.login_method = method;
            },
            check_mobile() {
                this.is_send = true;
            },

            // 获取手机验证码
            send_sms() {
                if (!this.phone) {
                    this.$message({
                        message: '手机号不能为空',
                        type: 'warning',
                        duration: 1000
                    });
                    return false  // 直接结束逻辑
                }
                if (!this.phone.match(/^1[3-9][0-9]{9}$/)) {
                    this.$message({
                        message: '手机号有误',
                        type: 'warning',
                        duration: 1000,
                    });
                    this.phone = '';
                    return false;
                }
                if (!this.is_click) {
                    this.code_phone = this.phone
                    this.is_click = true
                    let sms_interval_time = 60;
                    this.sms_interval = "发送中...";
                    let timer = setInterval(() => {
                        if (sms_interval_time <= 1) {
                            this.is_click = false
                            clearInterval(timer);
                            this.sms_interval = "重新发送";
                        } else {
                            sms_interval_time -= 1;
                            this.sms_interval = `${sms_interval_time}秒后再发`;
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
            },


            // 用户名密码登录
            login() {
                if (!(this.username && this.password)) {
                    this.$message({
                        message: '请填好账号密码',
                        type: 'warning',
                        duration: 1500
                    });
                    return false  // 直接结束逻辑
                }
                this.$http({
                    url: this.$settings.base_url + '/api/student/login/',
                    method: 'post',
                    data: {
                        username: this.username,
                        password: this.password,
                    }
                }).then(data => {
                    if (data.data.code === 200) {
                        let username = data.data.result.username;
                        let user_id = data.data.result.user_id;
                        let token = data.data.result.token;
                        let avatar = data.data.result.avatar

                        this.user = data.data.result
                        this.$cookies.set('username', username, '7d');
                        this.$cookies.set('user_id', user_id, '7d');
                        this.$cookies.set('token', token, '7d');
                        this.$cookies.set('avatar', avatar, '7d');
                        this.$message({
                            type: 'success',
                            message: data.data.msg
                        });
                        this.dialogVisible = true
                        this.$router.push('/home')
                    } else {
                        this.$message({
                            type: 'warning',
                            message: `${data.data.msg}`
                        });
                    }
                })
            },

            // 手机短信登录
            phone_login() {
                if (!(this.phone && this.code)) {
                    this.$message({
                        message: '手机号或验证码不能为空!',
                        type: 'error',
                        duration: 1500
                    });
                    return false
                }
                if (this.phone !== this.code_phone) {
                    this.$message({
                        message: '手机号与获取短信手机不一致!',
                        type: 'error',
                        duration: 2000
                    });
                    return false
                }
                this.$http({
                    url: this.$settings.base_url + '/api/student/login_phone/',
                    method: 'post',
                    data: {
                        // phone: this.code_phone,
                        phone: this.phone,
                        code: this.code,
                    }
                }).then(data => {
                    if (data.data.code === 200) {
                        let username = data.data.result.username;
                        let user_id = data.data.result.user_id;
                        let token = data.data.result.token;
                        let avatar = data.data.result.avatar

                        this.user = data.data.result
                        this.$cookies.set('username', username, '7d');
                        this.$cookies.set('user_id', user_id, '7d');
                        this.$cookies.set('token', token, '7d');
                        this.$cookies.set('avatar', avatar, '7d');
                        this.$message({
                            type: 'success',
                            message: data.data.msg
                        });
                        this.dialogVisible = true
                        this.$router.push('/home')
                    } else {
                        this.$message({
                            message: data.data.msg,
                            type: 'error',
                            duration: 1500
                        });
                        this.phone = ''
                        this.code = ''
                    }
                })
            },

            // 找回密码
            retrieve_pwd() {
                let _this = this
                _this.$router.push('/Retrieve_pwd')
            }
        }
    }
</script>

<style scoped>
    .lowin-brand {
        overflow: hidden;
        width: 90px;
        height: 90px;
        margin: 0 auto -50px auto;
        border-radius: 50%;
        -webkit-box-shadow: 0 4px 40px rgba(0, 0, 0, .07);
        box-shadow: 0 4px 40px rgba(0, 0, 0, .07);
        padding: 10px;
        background-color: #fff;
        z-index: 1;
        position: relative;
        top: -60px;
    }

    .login {
        width: 100vw;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 10;
        background-color: rgba(0, 0, 0, 0.2);
    }

    .box {
        width: 360px;
        height: 480px;
        background-color: white;
        position: relative;
        top: calc(50vh - 240px);
        left: calc(50vw - 200px);
        box-shadow: grey 0px 0px 30px 3px;
    }

    /*.el-icon-close {*/
    /*    position: absolute;*/
    /*    font-weight: bold;*/
    /*    font-size: 20px;*/
    /*    top: 10px;*/
    /*    right: 10px;*/
    /*    cursor: pointer;*/
    /*}*/

    .el-icon-close:hover {
        color: darkred;
    }

    .content {
        position: absolute;
        top: 110px;
        width: 280px;
        left: 40px;
    }

    .nav {
        font-size: 18px;
        height: 38px;
        border-bottom: 2px solid darkgrey;
    }

    .nav > span {
        margin: 0 30px 0 35px;
        color: darkgrey;
        user-select: none;
        cursor: pointer;
        padding-bottom: 10px;
        border-bottom: 2px solid darkgrey;
    }

    .nav > span.active {
        color: #3fb7ff;
        border-bottom: 3px solid #3fb7ff;
        padding-bottom: 9px;
    }

    .el-input, .el-button {
        margin-top: 40px;
    }

    .el-button {
        width: 100%;
        font-size: 18px;
    }

    .foot > span {
        float: right;
        font-weight: 600;
        margin-top: 30px;
        color: steelblue;
        cursor: pointer;
    }

    .sms {
        color: steelblue;
        cursor: pointer;
        display: inline-block;
        width: 70px;
        text-align: center;
        user-select: none;
    }
</style>