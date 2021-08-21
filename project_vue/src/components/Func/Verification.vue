<template>
    <div>
        <el-row style="margin-top: 33px">
            <h2>账号验证</h2>
            <el-col :span="6" :offset="9">
                <el-input
                        placeholder="请输入用户名"
                        prefix-icon="el-icon-user-solid"
                        v-model="username"
                        clearable>
                </el-input>
                <el-row>
                    <el-col :span="14">
                        <el-input
                                placeholder="请输入验证码"
                                prefix-icon="el-icon-s-comment"
                                v-model="code"
                                clearable>
                            <img src="" alt="">
                        </el-input>
                    </el-col>
                    <el-col :span="8">
                        <div style=" color: white;border-radius: 10px;margin-top: 30px">
                            <img ref="img" @click="img_code" height="40" width="160"
                                 :src="this.$settings.base_url+'/api/'+'random_num/'">
                        </div>
                    </el-col>
                </el-row>
                <el-button @click="send_code" type="success">确定</el-button>
            </el-col>
        </el-row>
    </div>
</template>

<script>

    export default {
        name: "Verification",
        data() {
            return {
                username: '',
                code: '',
                sRc: '',
            }
        },
        methods: {
            img_code() {
                this.sRc = this.$refs.img.src + '?'
                this.$refs.img.src = this.sRc
            },

            // 校验当前用户是否存在
            send_code() {
                if (!(this.username && this.code)) {
                    this.$message({
                        message: '用户名或验证码不能为空!',
                        type: 'warning',
                        duration: 1500
                    });
                    return false  // 直接结束逻辑
                }
                this.$http({
                    url: this.$settings.base_url + '/api/student/find_account/',
                    method: 'post',
                    data: {
                        username: this.username,
                        code: this.code
                    }
                }).then(data => {
                    // console.log(data)
                    if (data.data.code === 200) {
                        this.$emit('method')
                        sessionStorage.email = data.data.result.email;
                        sessionStorage.phone = data.data.result.phone;
                        sessionStorage.username = data.data.result.username;
                    } else{
                        if (data.data.code === 999) {
                            this.$message({
                                type: 'error',
                                message: '访问频率超过了限制,请一分钟后重试!',
                            });
                        } else {
                            this.$message({
                                type: 'warning',
                                message: data.data.msg
                            });
                            this.sRc = this.$refs.img.src + '?'
                            this.$refs.img.src = this.sRc
                        }
                    }
                })
            }
        },
    }
</script>

<style scoped>
    .el-input, .el-button {
        margin-top: 30px;
    }

    .el-button {
        width: 100%;
        font-size: 18px;
    }
</style>