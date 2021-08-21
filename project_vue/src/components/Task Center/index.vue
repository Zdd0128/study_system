<template>
    <div class="row">
        <!--任务中心-->
        <div style="height: 320px;width: 100%;margin-top: 2%" class="app-item-contain el-row">
            <span style="margin-left: -80%;border-left: 10px solid lightseagreen; padding-left: 10px;font-size: 24px;font-weight: 600">任务中心</span>
            <div style="padding-left: 7%;margin-top: 2%">
                <div class="el-col el-col-4 el-col-offset-2">
                    <div class="el-card is-always-shadow">
                        <img src="../../assets/exam-paper/task.png"
                             class="image">
                        <div style="padding: 14px;">
                            <span class="task duties">每日任务</span>
                            <div class="bottom clearfix">
                                <button @click="task_func" type="button"
                                        class="el-button button el-button--text el-button--medium"><!---->
                                    <span class="task_take">去做任务</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/task.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task duties">每周任务</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">去做任务</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/task.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task duties">每月任务</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">去做任务</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/task.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task duties">测试任务</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">去做任务</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow">
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/task.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task duties">测试任务</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">去做任务</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--基础试卷-->
        <div style="height: 320px;width: 100%;margin-top: 2%" class="app-item-contain el-row">
            <span style="margin-left: -80%;border-left: 10px solid orange; padding-left: 10px;font-size: 24px;font-weight: 600">基础试卷</span>
            <div style="padding-left: 7%;margin-top: 2%">
                <div class="el-col el-col-4 el-col-offset-2">
                    <div class="el-card is-always-shadow">
                        <img src="../../assets/exam-paper/paper.png"
                             class="image">
                        <div style="padding: 14px;">
                            <span class="task paper">Python</span>
                            <div class="bottom clearfix">
                                <button @click="paper_func" type="button"
                                        class="el-button button el-button--text el-button--medium"><!---->
                                    <span class="task_take">开始做题</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/paper.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task paper">Web前端</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">开始做题</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/paper.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task paper">Django</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">开始做题</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/paper.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task paper">MySql</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">开始做题</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow">
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/paper.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task paper">Linux</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">开始做题</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--提升试卷-->
        <div style="height: 320px;width: 100%;margin-top: 2%" class="app-item-contain el-row">
            <span style="margin-left: -80%;border-left: 10px solid dodgerblue; padding-left: 10px;font-size: 24px;font-weight: 600">提升试卷</span>
            <div style="padding-left: 7%;margin-top: 2%">
                <div class="el-col el-col-4 el-col-offset-2">
                    <div class="el-card is-always-shadow">
                        <img src="../../assets/exam-paper/h_paper.png"
                             class="image">
                        <div style="padding: 14px;">
                            <span class="task promote">JAVA</span>
                            <div class="bottom clearfix">
                                <button @click="promote_func" type="button"
                                        class="el-button button el-button--text el-button--medium"><!---->
                                    <span class="task_take">提升自己</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/h_paper.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task promote">C语言</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">提升自己</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/h_paper.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task promote">Jquery</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">提升自己</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow"><!---->
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/h_paper.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task promote">GO语言</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">提升自己</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="el-col el-col-4 el-col-offset-0">
                    <div class="el-card is-always-shadow">
                        <div class="el-card__body" style="padding: 0px;">
                            <img src="../../assets/exam-paper/h_paper.png" class="image">
                            <div style="padding: 14px;">
                                <span class="task promote">PHP语言</span>
                                <div class="bottom clearfix">
                                    <button type="button"
                                            class="el-button button el-button--text el-button--medium"><!---->
                                        <span class="task_take">提升自己</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "index",
        data() {
            return {}
        },
        methods: {
            task_func() {
                this.$router.push('/home/task')
            },
            paper_func() {
                this.$router.push('/home/basics_paper')
            },
            promote_func() {
                this.$router.push('/home/senior_paper')
            }
        },

    }
</script>

<style scoped>
    .image {
        height: 120px;
        width: 72%;
        margin-top: 20px
    }

    .el-card {
        height: 210px;
        width: 82%;
        box-shadow: 0 0 3px 0 #aaa;
    }

    .el-col {
        margin-left: 31px;
    }

    .task {
        float: left;
        font-size: 18px;
    }

    .paper {
        color: orange;
    }

    .duties {
        color: #00abb2;
    }

    .promote {
        color: #ff1322;
    }

    .task_take {
        margin-right: -50px;
        position: relative;
        top: 18px;
    }
</style>