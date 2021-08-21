<template>
    <div class="con">
        <Count_down></Count_down>
        <el-row>
            <el-col :span="20" :offset="2">
                <h1 style="margin-top: 80px">{{task_info.title}}</h1>
                <span>任务分值:{{task_info.task_score}}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <span>任务类型:{{task_info.type}}</span>
                <br>
                <br>
                <span style="padding-right: 290px">任务难度:</span>
                <el-rate style="position: relative;top: -18px;left: -30px" v-model="start"
                         disabled
                         text-color="#ff9900"
                         score-template="{value}">
                </el-rate>
                <el-card class="box-card">
                    <div style="height: 18px">
                        <h3 style="float: left;margin-top: -6px">简答题</h3>
                    </div>
                    <div v-for="(que,index) in task_info.question_list" class="text item">
                        <span style="float: left;margin-left: 30px;margin-top: 10px">{{index+1}}.{{que.title}}</span>
                        <span style="float: left;margin-left: 30px;margin-top: 30px"></span>
                        <br>
                        <br>
                        <br>
                        <quill-editor
                                class="editor"
                                ref="myTextEditor"
                                :options="editorOption"
                                @change="onEditorChange($event,que.que_id)">
                        </quill-editor>
                        <br>
                        <br>
                    </div>
                    <br>
                    <br>
                    <br>
                </el-card>
                <br>
                <br>
                <el-button type="success" @click="open">提交</el-button>
                <el-button type="info" @click="ret_home">返回</el-button>
                <br>
                <br>
                <br>
                <br>
            </el-col>
        </el-row>
    </div>
</template>

<script>

    import Count_down from '../../components/Func/Count_down'

    export default {
        name: "Task",
        components: {
            Count_down
        },
        data() {
            return {
                task_info: '',
                start: null,
                content: null,
                que_answer: {},
                task_type: null,
                que_id_list: [],
                answer_list: [],
                task_id: null,
                editorOption: {
                    modules: {
                        toolbar: [
                            ["bold", "italic"], // 加粗 斜体
                            [{indent: "-1"}, {indent: "+1"}], // 缩进
                            ["clean"], // 清除文本格式
                        ], //工具菜单栏配置
                    },
                    placeholder: '请输入答案...', //提示
                    readyOnly: false, //是否只读
                    theme: 'snow', //主题 snow/bubble
                    syntax: true, //语法检测
                },

            }
        },

        created() {
            // this.$store.commit('is_show', false);
            this.$settings.count_down(new Date(new Date(new Date().toLocaleDateString()).getTime() + 24 * 60 * 60 * 1000 - 1))
            this.$http({
                url: this.$settings.base_url + '/api/exam/day_task/',
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                if (data.data.code === 200) {
                    // console.log(data)
                    this.task_id = data.data.result[0].id
                    this.task_info = data.data.result[0]
                    this.start = Number(data.data.result[0].task_level)
                    this.task_type = Number(data.data.result[0].task_type)
                    for (let que of data.data.result[0].question_list) {
                        this.que_id_list.push(que.que_id)
                    }
                } else {
                    this.$message({
                        message: data.data.msg,
                        type: 'error',
                        duration: 1500
                    });
                }
            })
        },
        methods: {
            // 添加任务和答案
            onEditorChange(data, que_id) {
                for (let id of this.que_id_list) {
                    if (que_id === id) {
                        this.que_answer[que_id] = data.text.replace('\n', '')
                    }
                }
            },

            // 提交任务
            open() {
                let arr = Object.keys(this.que_answer)
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
                    title: '任务提交',
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
                        message: '任务提交成功!'
                    });
                    for (let answer in this.que_answer) {
                        this.answer_list.push({que_id: answer, user_answer: this.que_answer[answer]})
                    }
                    this.$http({
                        url: this.$settings.base_url + '/api/exam/save_task/?user_id=' + this.$cookies.get('user_id') + '&task_id=' + this.task_id,
                        method: 'post',
                        headers: {
                            token: this.$cookies.get('token')
                        },
                        data: this.answer_list
                    }).then(data => {
                        if (data.data.code === 200) {
                            // this.$store.commit('is_show', true);
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
    span {
        font-size: 18px;
    }

    .text {
        font-size: 14px;
    }

    .item {
        padding: 18px 0;
    }

    .box-card {
        margin-top: 30px;
        width: 100%;
    }

    .quill-editor {
        height: 140px;
        width: 88%;
        margin-left: 6%;
    }
</style>