<template>
    <div class="retrieve_pwd">
        <h1>找回密码流程:</h1>
        <el-row>
            <el-col :span="14" :offset="5">
                <el-steps :active="number" simple>
                    <el-step title="第一步:验证账号" icon="el-icon-search"></el-step>
                    <el-step title="第二步:找回方式" icon="el-icon-upload"></el-step>
                    <el-step title="第三步:找回密码" icon="el-icon-upload"></el-step>
                </el-steps>
            </el-col>
        </el-row>
        <component :is="who" @method="method_pwd" :is_method="method" @success="success_pwd"></component>


        <Footer class="footer"></Footer>
    </div>
</template>

<script>
    import Verification from "../components/Func/Verification";
    import Method from "../components/Func/Method";
    import Success from "../components/Func/Success";
    import Footer from "../components/Home/Footer";

    export default {
        name: "Retrieve_pwd",
        data() {
            return {
                who: 'Verification',
                number: 1,
                method: ''
            }
        },

        methods: {
            method_pwd() {
                this.who = 'Method'
                this.number = 2
            },
            success_pwd() {

                this.who = 'Success'
                this.number = 3
            }
        },

        components: {
            Verification,
            Method,
            Success,
            Footer
        }
    }
</script>

<style scoped>
    .footer {
        position: fixed;
        bottom: 0;
    }
</style>