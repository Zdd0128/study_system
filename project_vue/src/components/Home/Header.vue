<template>
    <div class="header">
        <div class="nav">
            <div class="center">
                <ul class="left-part">
                    <li style="margin-left: -40px" class="logo">
                        <router-link to="/home">
                            <img data-v-07d8fcee=""
                                 src="../../assets/logo.jpg" height="34"
                                 style="margin-left: 15px;">
                        </router-link>
                    </li>
<!--                    <li>-->
<!--                        <div id="now_time"></div>-->
<!--                    </li>-->
                </ul>
            </div>

            <div class="right-part">
                <div>
                    <ul>
                        <li class="ele">
                        <span @click="goPage('/home')"
                              :class="{active: url_path === '/home'}">首页</span>
                        </li>
                        <li class="ele">
                        <span @click="goPage('/home/video')"
                              :class="{active: url_path === '/home/video'}">视频课堂</span>
                        </li>
                        <li class="ele">
                        <span @click="goPage('/home/paper')"
                              :class="{active: url_path === '/home/paper'}">试卷中心</span>
                        </li>
                        <li class="ele">
                        <span @click="goPage('/home/record')"
                              :class="{active: url_path === '/home/record'}">考试记录</span>
                        </li>
                        <li class="ele" style="margin-right: 50px">
                        <span @click="goPage('/home/question')"
                              :class="{active: url_path === '/home/question'}">错题本</span>
                        </li>
                    </ul>

                    <el-dropdown>
                        <el-avatar style="margin-right: -40px;position: relative" class="el-dropdown-link avatar"
                                   :size="size"
                                   :src="this.$settings.base_url +'/media/'+avatar"></el-avatar>
                        <el-dropdown-menu slot="dropdown">
                            <el-dropdown-item>
                                <span @click="info('/user/'+username)">个人中心</span>
                            </el-dropdown-item>
                            <el-dropdown-item>
                                <span @click="logout">退出登录</span>
                            </el-dropdown-item>
                        </el-dropdown-menu>
                    </el-dropdown>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import Login from '../../views/login/index'
    import Register from "../../views/register/index"

    export default {
        name: "Header",
        data() {
            return {
                url_path: sessionStorage.url_path || '/',
                token: '',
                username: '',
                avatar: '',
                is_login: false,
                is_register: false,
                size: 36,
            }
        },
        methods: {
            goPage(url_path) {
                // 已经是当前路由就没有必要重新跳转
                if (this.url_path !== url_path) {
                    this.$router.push(url_path);  // 路由跳转
                }
                sessionStorage.url_path = url_path;
            },
            close_login() {
                this.is_login = false;
            },
            close_register() {
                this.is_register = false;
            },
            logout() {
                this.token = '';
                this.username = '';
                this.$cookies.remove('username');
                this.$cookies.remove('user_id');
                this.$cookies.remove('token');
                this.$cookies.remove('avatar');
                this.$router.push('/login')
            },
            info(url_path) {
                if (this.url_path !== url_path) {
                    this.$router.push('/user/' + this.username)
                }
                sessionStorage.url_path = url_path;
            }
        },
        created() {
            this.$settings.time();
            sessionStorage.url_path = this.$route.path;
            this.url_path = this.$route.path;

            // 检测cookies，查看登录状态
            this.username = this.$cookies.get('username');
            this.token = this.$cookies.get('token');
            this.avatar = this.$cookies.get('avatar');
        },
        components: {
            Login,
            Register,
        }
    }
</script>

<style scoped>
    #now_time {
        font-size: 18px;
        margin-left: 10px;
        margin-top: 6px;
        font-weight: 600;
    }

    .ele span {
        color: grey;
        margin-top: -19px;
        margin-left: 16px;
    }

    .ele span:hover {
        border-bottom-color: #25a3ff;
    }

    .ele span.active {
        color: #25a3ff;
        border-bottom-color: #25a3ff;
    }

    .ele span.active {
        border-bottom-color: #25a3ff;
    }

    .header {
        background-color: white;
        height: 64px;
        box-shadow: 0 0 2px 0 #aaa;
    }

    .header:after {
        content: "";
        display: block;
        clear: both;
    }

    .slogan {
        background-color: #eee;
        height: 40px;
    }

    .slogan p {
        width: 1200px;
        margin: 0 auto;
        color: #aaa;
        font-size: 13px;
        line-height: 40px;
    }

    .nav {
        background-color: white;
        user-select: none;
        width: 1200px;
        margin: 0 auto;

    }

    .nav ul {
        padding: 15px 0;
        float: left;
    }

    .nav ul:after {
        clear: both;
        content: '';
        display: block;
    }

    .nav ul li {
        float: left;
    }

    .logo {
        margin-right: 20px;
    }

    .ele {
        margin: 0 20px;
    }

    .ele span {
        display: block;
        font: 15px/36px '微软雅黑';
        border-bottom: 2px solid transparent;
        cursor: pointer;
    }


    .right-part {
        float: right;
    }

    .right-part .line {
        margin: 0 10px;
    }

    .right-part span {
        line-height: 68px;
        cursor: pointer;
        position: relative; /*已经定位过了 */
    }

    .avatar {
        position: absolute;
        right: 10px;
        top: 14px;
    }

    .site__title {
        color: #f35626;
        background-image: -webkit-linear-gradient(92deg, #f35626, #feab3a);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        -webkit-animation: hue 10s infinite linear;
    }

    @-webkit-keyframes hue {
        from {

            -webkit-filter: hue-rotate(0deg);
            -moz-filter: hue-rotate(0deg);
        }
        to {
            -webkit-filter: hue-rotate(-360deg);
            -moz-filter: hue-rotate(-360deg);
        }
    }

    .left-part {
        margin-left: -130px;
    }

    .right-part {
        margin-right: -120px;
    }
</style>