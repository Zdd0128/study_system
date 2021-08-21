<template>
    <div>
        <Count_down></Count_down>
        <el-row>
            <el-col :span="20" :offset="2">
                <h1 style="margin-top: 80px">{{title}}</h1>
                <span>试卷分值:{{score}}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <span>适合专业:{{major}}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>考试时间:{{time}}分钟</span>
                <br>
                <br>
                <span style="padding-right: 120px">任务难度:</span>
                <el-rate style="position: relative;top: -18px;left: 40px" v-model="star"
                         disabled
                         text-color="#ff9900"
                         score-template="{value}">
                </el-rate>
                <el-card :key="index" v-for="(que,index) in que_list" :body-style="{ padding: '0px' }"
                         style="margin-bottom: 30px">
                    <p style="margin-left: -1040px;margin-top: 20px">
                        <span style="font-weight: 600;font-size: 16px;">{{index+1}}、{{que.title}}</span>(分值:{{que.score}})
                    </p>
                    <el-form>
                        <el-form-item style="margin-top: 30px;margin-left: -600px">
                            <el-radio-group @change="onEditorBlur($event,que.id)" v-model="que['V' + index]">
                                <el-radio style="margin-left: 300px" label="A">
                                    <span style="font-weight: 600;">A、</span>{{que.A}}
                                </el-radio>
                                <el-radio style="margin-left: 100px" label="B">
                                    <span style="font-weight: 600;">B、</span>{{que.B}}
                                </el-radio>
                                <el-radio style="margin-left: 100px" label="C">
                                    <span style="font-weight: 600;">C、</span>{{que.C}}
                                </el-radio>
                                <el-radio style="margin-left: 100px" label="D">
                                    <span style="font-weight: 600;">D、</span>{{que.D}}
                                </el-radio>
                            </el-radio-group>
                        </el-form-item>
                    </el-form>
                </el-card>
            </el-col>
        </el-row>
        <br>
        <br>
        <el-button type="success" @click="open">提交</el-button>
        <el-button type="info" @click="ret_home">返回</el-button>
        <br>
        <br>
        <br>
        <br>
    </div>
</template>

<script>
    import Count_down from '../../components/Func/Count_down'

    export default {
        name: "Basics_Paper",
        components: {
            Count_down
        },
        data() {
            return {
                que_list: [],
                title: '',
                major: '',
                score: null,
                time: '',
                star: '',
                user_answer: {},
                answer_list: [],
                paper_id: null,
            }
        },
        created() {
            // this.$store.commit('paper_show', true);
            this.$settings.count_down(new Date().setMinutes(new Date().getMinutes() + 20))
            this.$http({
                url: this.$settings.base_url + '/api/exam/exam_paper/',
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                if (data.data.code === 200) {
                    this.paper_id = data.data.result[0].id
                    this.que_list = data.data.result[0].get_all_question_bank
                    this.title = data.data.result[0].title
                    this.major = data.data.result[0].get_course
                    this.score = data.data.result[0].paper_score
                    this.time = data.data.result[0].time
                    this.star = Number(data.data.result[0].paper_level)
                }
            })
        },
        methods: {
            onEditorBlur(data, que_id) {
                this.user_answer[que_id] = data
            },
            open() {
                let arr = Object.keys(this.user_answer)
                if (arr.length === 0) {
                    this.$message({
                        message: '提交的答案不能为空!',
                        type: 'error',
                        duration: 1500
                    });
                    return false
                }
                const h = this.$createElement;
                this.$msgbox({
                    title: '试卷提交',
                    message: h('p', null, '提交后不可修改,确定要提交吗?'),
                    showCancelButton: true,
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    beforeClose: (action, instance, done) => {
                        if (action === 'confirm') {
                            instance.confirmButtonLoading = true;
                            instance.confirmButtonText = '执行中...';
                            setTimeout(() => {
                                done();
                                setTimeout(() => {
                                    instance.confirmButtonLoading = false;
                                }, 300);
                            }, 1500);
                        } else {
                            done();
                        }
                    }
                }).then(action => {
                    this.$message({
                        type: 'success',
                        message: '试卷提交成功!'
                    });
                    for (let answer in this.user_answer) {
                        this.answer_list.push({que_id: answer, user_answer: this.user_answer[answer]})
                    }

                    this.$http({
                        url: this.$settings.base_url + '/api/exam/save_paper/?user_id=' + this.$cookies.get('user_id') + '&paper_id=' + this.paper_id,
                        method: 'post',
                        headers: {
                            token: this.$cookies.get('token')
                        },
                        data: this.answer_list
                    }).then(data => {
                        if (data.data.code === 200) {
                            // this.$store.commit('add_count', 1);
                            // if (this.$store.state.count === 2) {
                            //     this.$store.commit('paper_show', true);
                            // }
                            this.$router.push('/home')
                        }
                    })
                });
            },
            ret_home() {
                this.$router.push('/home')
            }
        }
    }
</script>

<style scoped>

</style>