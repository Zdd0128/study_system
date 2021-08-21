<template>
    <div style="width: 100%">
        <Header></Header>
        <el-row style="margin-top: 30px">
            <el-col :span='6' :offset="2">
                <el-card shadow="hover">
                    <div slot="header">
                        <span>个人信息</span>
                    </div>
                    <el-row>
                        <el-upload :action="this.$settings.base_url+'/api/student/editor_info/editor_avatar/'"
                                   accept="image/jpeg,image/gif,image/png"
                                   :before-upload="onBeforeUpload"
                                   :on-success="uploadSuccess"
                                   :headers="header"
                                   :show-file-list="false">
                            <el-avatar @click="handlePictureCardPreview(file)" class="el-dropdown-avatar"
                                       :size="100"
                                       :src="this.$settings.base_url +'/media/'+ form.avatar">
                            </el-avatar>
                        </el-upload>
                    </el-row>
                    <el-row style="margin-top: 10px" class="user-info-userName">
                        <label>{{form.username}}</label>
                    </el-row>
                    <el-divider/>
                    <el-row style="text-align: left;position: relative" class="user-info-fullInfo">
                        <p style="position: absolute;top: 0px">姓名：{{form.real_name}}</p><br>
                        <p style="position: absolute;top: 24px">专业：{{form.major}}</p><br>
                        <p style="position: absolute;top: 48px">学院：{{form.college}}</p><br>
                        <p style="position: absolute;top: 72px">注册时间：{{form.create_time}}</p><br>
                        <br>
                        <br>
                        <br>
                        <br>
                    </el-row>
                </el-card>
            </el-col>
            <el-col :span='13' :offset="1">
                <el-card shadow="hover">
                    <el-tabs active-name="event" type="card">
                        <el-tab-pane label="用户动态" name="event">
                            <!--                            {{user_dynamics_list}}-->
                            <div class="block" style="position: relative">
                                <el-timeline :reverse="true">
                                    <el-timeline-item
                                            placement="top"
                                            :key="item.id"
                                            v-for="item in user_dynamics_list">
                                        <p style="position: absolute;left: 16px;top: 0px;color: #999999">
                                            {{item.time}}</p>
                                        <el-card style="position: relative">
                                            <br>
                                            <p style="position:absolute;left: 40px">{{item.message}}</p>
                                            <br>
                                            <br>
                                        </el-card>
                                    </el-timeline-item>
                                </el-timeline>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="个人资料修改" name="update">
                            <el-form style="text-align: left" :model="form" label-width="100px" :rules="rules">
                                <el-form-item label="真实姓名：" prop="real_name" required>
                                    <el-input v-model="form.real_name"></el-input>
                                </el-form-item>
                                <el-form-item label="年龄：">
                                    <el-input v-model="form.age"></el-input>
                                </el-form-item>
                                <el-form-item label="性别：">
                                    <el-select v-model="form.sex" placeholder="性别" clearable>
                                        <el-option value="女">女</el-option>
                                        <el-option value="男">男</el-option>
                                        <el-option value="保密">保密</el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="专业：">
                                    <el-select v-model="form.major" placeholder="专业" clearable>
                                        <el-option v-for="major in major_list" :value="major.major_name">
                                        </el-option>
                                    </el-select>
                                </el-form-item>
                                <el-form-item label="邮箱：">
                                    <el-input v-model="form.email"></el-input>
                                </el-form-item>
                                <el-form-item label="手机：">
                                    <el-input v-model="form.phone"></el-input>
                                </el-form-item>
                                <el-form-item>
                                    <el-button type="primary" @click="save_info">保存</el-button>
                                </el-form-item>
                            </el-form>
                        </el-tab-pane>
                    </el-tabs>
                </el-card>
                <br>
                <br>
                <br>
                <br>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import Header from "../../components/Home/Header";

    export default {
        data() {
            return {
                header: {
                    token: this.$cookies.get('token')
                },
                user_dynamics_list: [],
                event: [],
                major_list: [],
                form: {
                    avatar: this.$cookies.get('avatar'),
                    real_name: '',
                    username: '',
                    age: '',
                    sex: '',
                    sex_id: '',
                    phone: '',
                    email: '',
                    major: '',
                    major_id: '',
                    create_time: 'null',
                    college: '',
                },
                rules: {
                    real_name: [
                        {required: true, message: '请输入真实姓名', trigger: 'click'}
                    ],
                }
            }
        },
        created() {
            // 获取专业列表
            this.$http({
                url: this.$settings.base_url + '/api/student/major/',
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                this.major_list = data.data
            })

            // 获取个人信息
            this.$http({
                url: this.$settings.base_url + '/api/student/info/' + this.$cookies.get('user_id') + '/',
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                this.form.real_name = data.data.real_name
                this.form.username = data.data.username
                this.form.age = data.data.age
                this.form.sex = data.data.get_sex
                this.form.major = data.data.get_major
                this.form.email = data.data.email
                this.form.phone = data.data.phone
                this.form.college = data.data.college
                this.form.create_time = this.$settings.show_time(data.data.create_time)
            })

            // 获取用户动态
            this.$http({
                url: this.$settings.base_url + '/api/student/user_dynamics_list/?user_id=' + this.$cookies.get('user_id'),
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                for (let obj of data.data.result) {
                    this.user_dynamics_list.push({
                        time: this.$settings.show_time(obj.create_time),
                        message: obj.message,
                        username: obj.get_user,
                    })
                }
            })
        },

        methods: {
            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            uploadSuccess(data, file) {
                if (data.code === 200) {
                    this.$message({
                        message: data.msg,
                        type: 'success',
                        duration: 1500
                    });
                    this.avatar = data.avatar
                    this.$cookies.set('avatar', data.avatar, '7d');
                } else {
                    this.$message({
                        message: data.msg,
                        type: 'error',
                        duration: 1500
                    });
                }
            },
            onBeforeUpload(file) {
                const isIMAGE = file.type === 'image/jpeg' || 'image/gif' || 'image/png';
                const isLt1M = file.size / 1024 / 1024 < 1;
                if (!isIMAGE) {
                    this.$message.error('上传文件只能是图片格式!');
                }
                if (!isLt1M) {
                    this.$message.error('上传文件大小不能超过 1MB!');
                }
                return isIMAGE && isLt1M;
            },
            save_info() {
                for (let major of this.major_list) {
                    if (this.form.major === major.major_name) {
                        this.form.major_id = major.id
                    }
                }
                if (this.form.sex === '女') {
                    this.form.sex_id = '0'
                } else if (this.form.sex === '男') {
                    this.form.sex_id = '1'
                } else {
                    this.form.sex_id = '2'
                }

                this.$http({
                    url: this.$settings.base_url + '/api/student/editor_info/' + this.$cookies.get('user_id') + '/',
                    method: 'put',
                    headers: {
                        token: this.$cookies.get('token')
                    },
                    data: {
                        'real_name': this.form.real_name,
                        'age': this.form.age,
                        'sex': this.form.sex_id,
                        'major': this.form.major_id,
                        'email': this.form.email,
                        'phone': this.form.phone,
                    }
                }).then(data => {
                    if (data.data.code === 200) {
                        this.$message({
                            message: data.data.msg,
                            type: 'success',
                            duration: 1500
                        });
                    } else {
                        if (data.data.msg.phone) {
                            this.$message({
                                message: '当前手机号已存在',
                                type: 'error',
                                duration: 1500
                            });
                        } else if (data.data.msg.email) {
                            this.$message({
                                message: '当前邮箱已存在',
                                type: 'error',
                                duration: 1500
                            });
                        } else {
                            this.$message({
                                message: '未知错误,请联系管理员!',
                                type: 'error',
                                duration: 1500
                            });
                        }
                    }
                })
            },
        },
        components: {
            Header,
        }
    }
</script>

<style scoped>
    .el-card {
        margin-top: 30px;
    }
</style>

