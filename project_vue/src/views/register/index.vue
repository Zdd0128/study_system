<template>
    <div class="register">
        <div class="box">
            <div class="lowin-brand">
                <img src="../../assets/Logo.png" alt="logo" style="width: 100%;margin-top: 12px">
            </div>
            <p style="color:rgb(63,200,240);font-size: 16px;font-weight: 600">学无止境</p>
            <div class="content">
                <el-form>
                    <el-input
                            placeholder="用户名"
                            prefix-icon="el-icon-s-custom"
                            v-model="username"
                            clearable>
                    </el-input>

                    <el-input
                            placeholder="邮箱"
                            prefix-icon="el-icon-s-comment"
                            v-model="email"
                            clearable>
                    </el-input>

                    <el-input
                            placeholder="手机号"
                            prefix-icon="el-icon-phone-outline"
                            v-model="phone"
                            clearable>
                    </el-input>

                    <el-input
                            placeholder="密码"
                            prefix-icon="el-icon-key"
                            v-model="password"
                            clearable
                            show-password>
                    </el-input>

                    <el-button @click="register" type="primary">注册</el-button>
                </el-form>
                <div class="foot">
                    <span @click="go_login">已有账号? 立即登录</span>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "Register",
        data() {
            return {
                username: '',
                password: '',
                email: '',
                phone: '',
            }
        },

        methods: {
            close_register() {
                this.$emit('close', false)
            },
            go_login() {
                this.$router.push('/login')
            },
            get_data() {
                return {
                    username: this.username,
                    email: this.email,
                    phone: this.phone,
                    password: this.password,
                }
            },
            register() {
                if (!(this.username && this.password && this.email && this.phone)) {
                    this.$message({
                        message: '注册相关信息不能为空',
                        type: 'warning',
                        duration: 1500
                    });
                    return false  // 直接结束逻辑
                }
                this.$http({
                    url: this.$settings.base_url + '/api/student/register/',
                    method: 'post',
                    data: this.get_data(),
                }).then(data => {
                    if (data.data.code === 200) {
                        this.$message({
                            type: 'success',
                            message: `${data.data.msg}`,
                        });
                        this.go_login()
                    } else {
                        if (data.data.msg.phone) {
                            this.$message({
                                type: 'warning',
                                message: '该手机号已被注册',
                            });
                        } else {
                            this.$message({
                                type: 'warning',
                                message: `${data.data.msg}`,
                            });
                        }
                    }
                })
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

    .register {
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
        height: 500px;
        background-color: white;
        position: relative;
        top: calc(50vh - 240px);
        left: calc(50vw - 200px);
        box-shadow: grey 0px 0px 30px 3px;
    }


    .content {
        position: absolute;
        top: 75px;
        width: 280px;
        left: 40px;
    }


    .nav > span {
        margin-left: 90px;
        color: darkgrey;
        user-select: none;
        cursor: pointer;
        padding-bottom: 10px;
        border-bottom: 2px solid darkgrey;
    }

    .nav > span.active {
        color: black;
        border-bottom: 3px solid black;
        padding-bottom: 9px;
    }

    .el-input {
        margin-top: 32px;
    }

    .el-button {
        width: 100%;
        margin-top: 30px;
        font-size: 14px;
    }

    .foot > span {
        float: right;
        margin-top: 20px;
        color: steelblue;
        cursor: pointer;
        font-weight: 600;
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