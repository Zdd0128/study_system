<template>
    <div>
        <br>
        <br>
        <br>
        <div>
            <br>
            <br>
            <p style="color: black;font-size: 24px">恭喜!</p>
            <br>
            <p style="color: black;font-size: 18px">您已通过验证,请设置新的密码!</p>
        </div>
        <br>
        <br>
        <br>
        <el-row>
            <el-col :span="6" :offset="9">
                <el-input
                        placeholder="请输入密码"
                        v-model="new_password"
                        prefix-icon="el-icon-key"
                        show-password>
                </el-input>
                <br>
                <br>
                <br>
                <el-input
                        placeholder="请确认密码"
                        v-model="re_password"
                        prefix-icon="el-icon-key"
                        show-password>
                </el-input>
                <br>
                <br>
                <br>
                <el-button style="width:100%" @click="save_pwd" type="success">保 存</el-button>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    export default {
        name: "Email_editor_pwd",
        data() {
            return {
                new_password: '',
                re_password: '',
                username: '',
            }
        },
        methods: {
            save_pwd() {
                if ((!this.new_pwd && this.re_pwd)) {
                    this.$message({
                        message: '密码不能为空!',
                        type: 'warning',
                        duration: 1500
                    });
                    return false
                }
                if ((!this.new_pwd === this.re_pwd)) {
                    this.$message({
                        message: '两次密码输入不一致,请重新输入',
                        type: 'warning',
                        duration: 1500
                    });
                    return false
                }
                // console.log(this.$cookies.get('email_token'))
                this.$http({
                    url: this.$settings.base_url + '/api/student/email_save_pwd/',
                    method: 'post',
                    data: {
                        token: this.$cookies.get('email_token'),
                        new_password: this.new_password,
                        re_password: this.re_password
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
            }
        }
    }
</script>

<style scoped>

</style>