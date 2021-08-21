<template>
    <el-carousel style="width: 100%;margin-top: 10px" :interval="9000" arrow="always" type="card">
        <el-carousel-item v-for="banner in banner_list">
            <img height="100%" width="100%" :src="banner.image" alt="">
        </el-carousel-item>
    </el-carousel>
</template>
<script>

    export default {
        name: 'Banner',
        data() {
            return {
                banner_list: []
            }
        },
        mounted() {
            this.$http({
                url: this.$settings.base_url + '/api/exam/banner/',
                method: 'get',
                headers:{
                    token:this.$cookies.get('token')
                }
            }).then(data => {
                this.banner_list = data.data.result
            })
        },


    }
</script>

<style>
    .el-carousel__item h3 {
        color: #475669;
        font-size: 14px;
        opacity: 0.75;
        line-height: 200px;
        margin: 0;

    }

    .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
    }

    .el-carousel__item:nth-child(2n+1) {
        background-color: #d3dce6;
    }
</style>






