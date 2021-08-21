<template>
    <div>
        <!--邮箱找回密码-->
        <div v-if="methods==='email'">
            <div style="margin-top: 53px">
                <img src="../../assets/img/success.jpg" height="100px" width="100px" alt="">
            </div>
            <h2>恭喜,发送成功</h2>
            <span style="color: #999999;font-size: 14px">密码重置邮件已发送到您的邮箱</span>
            <br>
            <br>
            <p style="font-size: 14px;color: #999999">没有收到邮件?
                <el-link @click="send_email_pwd" :underline="false" type="primary">重新发送</el-link>
            </p>
            <br>
            <br>
            <el-button><a href="https://mail.qq.com/">去邮箱查看</a></el-button>
        </div>

        <!--手机找回密码-->
        <div v-else>
            <el-row style="margin-top: 33px">
                <div>
                    <span>亲爱的:<span style="font-weight: 800;font-size: 16px">{{username}}</span></span>
                    <br>
                    <br>
                    <p>
                        <span style="color: black;font-size: 13px">恭喜,您已通过验证,请设置新的密码! </span>
                        <span style="color: #999999;font-size: 10px">有效时间还剩{{time}}秒!</span>

                    </p>
                </div>
                <el-col :span="6" :offset="9" style="margin-top: 30px">
                    <el-input
                            show-password
                            placeholder="新密码"
                            prefix-icon="el-icon-key"
                            v-model="new_pwd"
                            clearable>
                    </el-input>
                    <br>
                    <br>
                    <br>
                    <el-input
                            show-password
                            placeholder="确认密码"
                            prefix-icon="el-icon-key"
                            v-model="re_pwd"
                            clearable>
                    </el-input>
                    <br>
                    <br>
                    <br>
                    <el-button style="width:100%" @click="editor_pwd" type="success">保存</el-button>
                </el-col>
            </el-row>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Success",
        data() {
            return {
                methods: '',
                new_pwd: '',
                re_pwd: '',
                time: '',
                username: sessionStorage.username,
            }
        },
        mounted() {

        },
        created() {
            this.$EventBus.$on('email', data => {
                this.methods = data
            })
            let sms_interval_time = 300;
            let timer = setInterval(() => {
                if (sms_interval_time <= 1) {
                    clearInterval(timer);
                    this.$router.push('/login')
                } else {
                    sms_interval_time -= 1;
                    this.time = `${sms_interval_time}`;
                }
            }, 1000);
        },
        methods: {
            // 手机保存密码
            editor_pwd() {
                if (!(this.new_pwd === this.re_pwd)) {
                    this.$message({
                        message: '两次密码输入不一致',
                        type: 'warning',
                        duration: 1500
                    });
                    return
                }
                this.$http({
                    url: this.$settings.base_url + '/api/student/phone_pwd/',
                    method: 'post',
                    data: {
                        password: this.new_pwd,
                        re_pwd: this.re_pwd,
                        phone: sessionStorage.phone,
                    }
                }).then(data => {
                    if (data.data.code === 200) {
                        this.$message({
                            message: data.data.msg,
                            type: 'success',
                            duration: 1500
                        });
                        this.$router.push('/login')
                    } else {
                        this.$message({
                            message: data.data.msg,
                            type: 'error',
                            duration: 1500
                        });
                    }
                })
            },

            // 重新发送邮件
            send_email_pwd() {
                this.$http({
                    url: this.$settings.base_url + '/api/student/email_pwd/',
                    method: 'post',
                    data: {
                        email: sessionStorage.email
                    }
                }).then(data => {
                    if (data.data.code === 200) {
                        let token = data.data.token
                        this.$cookies.set('email_token', token, 60 * 5)
                        this.$message({
                            message: data.data.msg,
                            type: 'success',
                            duration: 1500
                        });
                        this.$EventBus.$emit('email', 'email');
                    } else if (data.data.code === 999) {
                        this.$message({
                            message: '访问频率超过了限制,请一分钟后重试!',
                            type: 'warning',
                            duration: 1500
                        });
                        return false
                    }
                })
            },
        }
    }
</script>

<style scoped>

</style>