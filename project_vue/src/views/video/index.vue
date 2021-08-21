<template>
    <div>
        <Header></Header>
        <br>
        <br>
        <span style="position: relative;left:-600px;font-weight: 700;font-size: 30px;border-left: red solid 10px;padding-left: 20px">学习专区</span>
        <div style="margin-left: 66px">
            <el-row style="margin-top: 4px;">
                <el-col :span="10" v-for="(obj,index) in course_info" :key="obj.id" style="margin-left: 60px">
                    <div @click="study_course(obj.id)">
                        <el-card :body-style="{padding: '0px', cursor:'pointer'}"
                                 style="border-radius: 6px;margin-top:20px;">
                            <img style="height: 270px;width: 100%;"
                                 :src="obj.course_img">
                            <div style="padding: 20px;position: relative;margin-top: -8px">
                                <p style="font-size: 16px;font-weight: 600; text-align: left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{obj.course_brief}}</p>
                                <span style="position: absolute;left:10px;top:60px;font-size: 14px;color: grey;">学习人数:{{obj.course_students}}</span>
                                <span style="position: absolute;right: 120px;top: 54px">
                                    课程价格:<span style="font-size: 24px;color: orangered;font-weight: 700">{{obj.course_price}}</span>
                                </span>
                                <br>
                                <br>
                            </div>
                        </el-card>
                    </div>
                    <el-button
                            v-if="unlock_course_list.length===0"
                            @click="buy_courses(obj.course_price,obj.id)"
                            type="warning"
                            size="small"
                            style="position:relative;left: 250px;top: -44px">立即解锁
                    </el-button>
                    <el-button
                            v-for="res of unlock_course_list"
                            v-if="obj.id===res"
                            @click="study_course(obj.id)"
                            type="warning"
                            size="small"
                            style="position:relative;left: 250px;top: -44px">马上学习
                    </el-button>
                    <el-button
                            v-else
                            @click="buy_courses(obj.course_price,obj.id)"
                            type="warning"
                            size="small"
                            style="position:relative;left: 250px;top: -44px">立即解锁
                    </el-button>
                </el-col>
            </el-row>
        </div>
        <br style="color: #999999">
        <br>
        <br>
        <span style="position: relative;left:-600px;font-weight: 700;font-size: 30px;border-left: deepskyblue solid 10px;padding-left: 20px">电影专区</span>
        <div style="margin-left: 66px">
            <el-row style="margin-top: 4px;">
                <el-col style="margin-left: -24px" :span="4" v-for="(movie, index) in movie_list">
                    <div @click="movie_video(movie.movie_link)"
                         style="cursor:pointer;margin-left: 92px;height: 260px;width: 160px;margin-top: 30px">
                        <img style="border-radius: 6px" height="240px" width="160px"
                             :src="movies_img_url+movie.movie_img" alt="">
                        <p style="font-size: 16px;font-weight: 600;margin-top: 20px">{{movie.movie_title}}</p>
                    </div>
                </el-col>
            </el-row>
        </div>
        <br>
        <br>
        <br>
        <br>
        <br>
        <Footer></Footer>
    </div>
</template>

<script>
    import Header from "../../components/Home/Header";
    import Footer from "../../components/Home/Footer";

    export default {
        name: "index",
        components: {
            Header,
            Footer
        },
        data() {
            return {
                unlock_course_list: [],
                movies_img_url: this.$settings.movies_url,
                course_info: '',
                movie_list: '',
                linux_info: '',
            };
        },
        mounted() {
            // 拿课程信息
            this.$http({
                url: this.$settings.base_url + '/api/exam/course/',
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                this.course_info = data.data
            })

            // 拿课程是否解锁信息
            this.$http({
                url: this.$settings.base_url + '/api/exam/course_buy/?user_id=' + this.$cookies.get('user_id') + '&order_status=1',
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                if (data.data.length !== 0) {
                    for (let obj of data.data) {
                        this.unlock_course_list.push(obj.course_id)
                    }
                }
            })

            // 拿电影信息
            this.$http({
                url: this.$settings.base_url + '/api/exam/movie_list/',
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                this.movie_list = data.data.result
            })
        },
        methods: {
            study_course(course_id) {
                if (course_id === 2) {
                    this.$message({
                        message: '该课程暂未开放,请联系管理员!',
                        type: 'error',
                        duration: 1500
                    });
                    return false
                }
                this.$http({
                    url: this.$settings.base_url + '/api/exam/course_is_buy/?user_id=' + this.$cookies.get('user_id') + '&course_id=' + course_id,
                    method: 'get',
                    headers: {
                        token: this.$cookies.get('token')
                    }
                }).then(data => {
                    if (data.data.length === 0) {
                        this.$message({
                            message: '您还未解锁该课程哦,请先购买!',
                            type: 'error',
                            duration: 1500
                        });
                        return false
                    }
                    if (data.data[0].order_status !== 1) {
                        this.$message({
                            message: '您还未解锁该课程哦,请先支付订单!',
                            type: 'error',
                            duration: 1500
                        });
                    } else {
                        this.$router.push('/home/video/course_detail/' + course_id)
                    }
                })


            },

            buy_courses(price, id) {
                if (id === 2) {
                    this.$message({
                        message: '该课程暂未开放,请联系管理员!',
                        type: 'error',
                        duration: 1500
                    });
                    return false
                }
                this.$http({
                    url: this.$settings.base_url + '/api/exam/pay_course/',
                    method: 'post',
                    headers: {
                        token: this.$cookies.get('token')
                    },
                    data: {
                        courses: [id,],
                        total_amount: price,
                    }
                }).then(data => {
                    if (data.data.code === 200) {
                        open(data.data.pay_url, '_self')
                    } else {
                        this.$message({
                            message: data.data.msg,
                            type: 'error',
                            duration: 1500
                        });
                    }
                })
            },
            movie_video(url) {
                let movie_url = url.split('.')[0]
                this.$router.push('/home/video/movie/' + movie_url)
            }
        }
    }
</script>

<style scoped>
    p:hover {
        color: coral;
    }
</style>