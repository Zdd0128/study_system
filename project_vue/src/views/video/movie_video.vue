<template>
    <div>
        <h2>{{movie_title}}</h2>
        <p style="margin-top: -10px;font-size: 12px;color: #999999"><span style="font-size: 12px;font-weight: 600;color: black"> 温馨提示:</span>如有卡顿,请暂停或缓存继续播放!!!
        </p>
        <div style="margin: auto;height: 680px;width: 1040px">
            <videoPlayer class="video-player vjs-custom-skin"
                         ref="videoPlayer"
                         :playsinline="true"
                         :options="playerOptions"
                         @play="onPlayerPlay($event)"
                         @pause="onPlayerPause($event)">
            </videoPlayer>
        </div>
    </div>
</template>

<script>
    import {videoPlayer} from 'vue-video-player';

    export default {
        name: "movie_video",
        components: {
            videoPlayer,
        },
        data() {
            return {
                movie_title: '',
                playerOptions: {
                    //https://www.jianshu.com/p/e8e747e33ef0
                    playbackRates: [0.75, 1.0, 1.5, 2.0], //播放速度
                    aspectRatio: '16:10', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
                    sources: [{ // 播放资源和资源格式
                        type: "video/mp4",
                        src: this.$settings.video_url + this.$route.params.url + '.mp4', //你的视频地址（必填）
                    }],

                }
            }
        },
        mounted() {
            this.movie_title = this.$route.params.url
        },

        methods: {
            onPlayerPlay() {
                // 当视频播放时，执行的方法
                // console.log('视频开始播放')
            },
            onPlayerPause() {
                // 当视频暂停播放时，执行的方法
                // console.log('视频暂停，可以打开广告了')
                alert('如有卡顿请暂停缓存播放!')
            },
        }
    }
</script>

<style scoped>

</style>