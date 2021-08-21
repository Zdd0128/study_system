<template>
    <div>
        <Header></Header>
        <el-row>
            <el-col>
                <el-col :span="14" style="margin-left: 164px">
                    <div style="width: 100%;height: 620px;position:relative;">
                        <p style="font-size: 18px;position: absolute;left: -20px;top: 0px;color: black;cursor:pointer;">
                            {{course_detail.course_brief}}</p>
                        <p style="font-size: 10px;position: absolute;left: -20px;top: 34px;color: darkgray">
                            <span>888.8万播放</span>&nbsp;&nbsp;·&nbsp;&nbsp;<span>66.6万弹幕</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>{{course_detail.course_pub_date}}</span>
                        </p>
                        <div style="position: relative;left: -20px;top: 64px">
                            <videoPlayer class="video-player vjs-custom-skin"
                                         ref="videoPlayer"
                                         :playsinline="true"
                                         :options="playerOptions"
                                         @play="onPlayerPlay($event)"
                                         @pause="onPlayerPause($event)">
                            </videoPlayer>
                        </div>
                        <el-card style="width: 100%;height:40px;position: absolute;left: -21px;top: 624px;">
                            <p style="position: absolute;left: 16px;top:12px;font-size: 12px;color: #576361">
                                <span style="font-size: 16px;font-weight: 600;color: black">66.6&nbsp;</span>万人正在看(全站66.6万+人在看),88.8万条弹幕<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;弹</span>
                            </p>
                            <div style="position: absolute;left: 400px;top: 0px">
                                <el-form>
                                    <el-form-item>
                                        <el-switch v-model="delivery"></el-switch>
                                    </el-form-item>
                                </el-form>
                            </div>
                            <div style="position: absolute;left: 520px;top: 6px">
                                <input style="cursor:pointer;width: 260px;height:26px;background-color:#e6e6e6;border:0px;outline: none;"></input>
                                <button style="margin-left: 0px;border: none;height: 26px">发送</button>

                            </div>
                            <span style="position: absolute;left:840px;top:7px;font-size: 26px;margin-left: 19px"
                                  class="el-icon-s-tools"></span>
                        </el-card>
                    </div>
                </el-col>

                <el-col :span="5" style="margin-left: 10px">
                    <div style="position: relative">
                        <div style="height: 71px;width: 100%;background-color: #ececec;border-radius: 40px;margin-top: 2px">
                            <img style="position: absolute;left:1px;height: 70px;width: 70px;border-radius: 50%"
                                 :src="this.$settings.base_url +'/media/avatar/video_logo.png'" alt="">
                        </div>
                        <span style="position: absolute;left: 80px;top: 2px;font-weight: 600;color: black">老男孩IT教育</span>
                        <span style="position: absolute;left: 96px;top: 22px;font-size: 10px;color: #a8a8a8">帮助有志向的年轻人走向成功</span>
                        <button style="cursor:pointer;height: 24px;background-color: #69b8f9;border-radius: 20px;width: 180px;border: none;position: absolute;left: 96px;top: 42px;">
                            关注+
                        </button>
                    </div>
                    <div style="margin-top: 12px">
                        <img style="width: 100%;height: 80px;" src="../../assets/img/gg.jpg" alt="">
                    </div>
                    <br>
                    <div style="width: 100%;height: 40px;background-color: rgb(239,239,239);border-radius: 4px">
                        <span style="cursor:pointer;position: absolute;left:1080px;top:210px;font-size: 16px">视频选集(1/{{course_chapter_list.length}})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
                                style="font-size: 13px;color: darkgray">自动连播</span></span>
                        <div style="position: absolute;right: 170px;top: 200px">
                            <el-form>
                                <el-form-item>
                                    <el-switch v-model="delivery1"></el-switch>
                                </el-form-item>
                            </el-form>
                        </div>
                    </div>
                    <div class="box"
                         style="width: 100%;height: 436px;background-color: rgb(239,239,239);border-radius: 4px">
                        <template>
                            <div class="infinite-list-wrapper" style="overflow:auto;position: relative">
                                <ul class="list"
                                    v-infinite-scroll="load"
                                    infinite-scroll-disabled="disabled">
                                    <li v-for="(obj,index) in course_chapter_list" class="list-item">
                                        <p @click="click_video(obj.chapter_link)"
                                           style="font-size: 13px;text-align: left;cursor:pointer">
                                            <span style="position: absolute;left: 12px">p{{index+1}}</span>
                                            <span style="margin-left: 60px">{{obj.chapter_name}}</span>
                                            <span style="float: right;margin-right: 30px">{{obj.chapter_time}}</span>
                                        </p>
                                    </li>
                                </ul>
                            </div>
                        </template>
                    </div>
                </el-col>
            </el-col>
        </el-row>
    </div>
</template>

<script>
    import Header from "../../components/Home/Header";
    import {videoPlayer} from 'vue-video-player';

    export default {
        name: "course_detail",
        components: {
            Header,
            videoPlayer
        },
        data() {
            return {
                count: 0,
                loading: false,
                delivery: false,
                delivery1: false,
                video_urls: '',
                course_detail: '',
                course_chapter_list: '',
                playerOptions: {
                    //https://www.jianshu.com/p/e8e747e33ef0
                    playbackRates: [0.75, 1.0, 1.5, 2.0], //播放速度
                    aspectRatio: '16:10', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
                    sources: [{ // 播放资源和资源格式
                        type: "video/mp4",
                        src: this.$settings.video_url + '01.编程与编程语言介绍.mp4' //你的视频地址（必填）
                        // src: this.$settings.video_url + '大话西游之大圣娶亲.mp4' //你的视频地址（必填）
                        // src: this.$settings.video_url + '头号玩家.mp4' //你的视频地址（必填）
                    }],

                }
            }
        },
        computed: {
            noMore() {
                return this.count >= 20
            },
            disabled() {
                return this.loading || this.noMore
            }
        },
        created() {
            this.$http({
                url: this.$settings.base_url + '/api/exam/course_video_detail/' + this.$route.params.pk + '/',
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                },
            }).then(data => {
                    if (data.data.code === 200) {
                        this.course_detail = data.data.result
                        this.course_chapter_list = data.data.result.course_chapter_list
                    } else {
                        this.$message({
                            message: data.data.msg,
                            type: 'error',
                            duration: 1500
                        });
                    }
                }
            )
        },
        methods: {
            load() {
                this.loading = true
                setTimeout(() => {
                    this.count += 2
                    this.loading = false
                }, 2000)
            },
            onPlayerPlay() {
                // 当视频播放时，执行的方法
                // console.log('视频开始播放')
            },
            onPlayerPause() {
                // 当视频暂停播放时，执行的方法
                // console.log('视频暂停，可以打开广告了')
            },
            click_video(data) {
                this.playerOptions.sources[0].src = this.$settings.video_url + data
            }
        },
    }
</script>

<style scoped>
    .box {
        width: 200px;
        height: 100px;
        background-color: pink;
        overflow: scroll;
        font-size: 20px;
        line-height: 40px;
        overflow-x: hidden;
        overflow-y: auto;

    }

    /*定义滚动条轨道 内阴影+圆角*/
    .box::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
        border-radius: 10px;
        background-color: #F5F5F5;
    }

    /*定义滑块 内阴影+圆角*/
    .box::-webkit-scrollbar-thumb {
        border-radius: 10px;
        -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
        background-color: #555;
    }
</style>