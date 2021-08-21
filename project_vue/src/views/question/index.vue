<template>
    <div>
        <Header></Header>
        <!--        <div class="hello">-->
        <!--            <h3>{{$store.state.count}}</h3>-->
        <!--            <div>-->
        <!--                <button @click="handleAddClick(10)">增加</button>-->
        <!--                <button @click="handleReduceClick(10)">减少</button>-->
        <!--            </div>-->
        <!--        </div>-->
        <el-col :span='12' style="margin-left: 90px;margin-top: 70px">
            <el-table

                    @current-change="click($event)"
                    :data="tableData"
                    style="width: 100%">
                <el-table-column
                        prop="title"
                        label="题干"
                        width="440">
                </el-table-column>
                <el-table-column
                        prop="pro_type"
                        label="题型"
                        width="80">
                </el-table-column>
                <el-table-column
                        prop="project"
                        label="学科"
                        width="80">
                </el-table-column>
                <el-table-column
                        prop="time"
                        label="做题时间"
                        width="160">
                </el-table-column>
                <el-table-column
                        v-if="false"
                        prop="answer"
                        label="用户答案"
                        width="0">
                </el-table-column>
                <el-table-column
                        v-if="false"
                        prop="id"
                        label="序号"
                        width="0">
                </el-table-column>
            </el-table>
            <el-pagination
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page.sync="filter.page"
                    :page-sizes="0"
                    :page-size="filter.page_size"
                    layout="prev, pager, next"
                    :total="count">
            </el-pagination>
        </el-col>
        <el-col :span='8' style="margin-left: 70px;margin-top: 70px">
            <el-card class="box-card">
                <div style="position: relative" v-if="que_list[num]" class="text item">
                    <p style="font-weight: 600;float: left">{{que_list[num].title}}</p>
                    <br>
                    <el-form>
                        <el-form-item style="margin-top: 30px">
                            <el-radio-group v-model="choice">
                                <el-radio
                                        :disabled="A"
                                        label="A">
                                    <span style="font-weight: 600;">A、</span>{{que_list[num].A}}
                                </el-radio>
                                <el-radio
                                        :disabled="B"
                                        label="B">
                                    <span style="font-weight: 600;">B、</span>{{que_list[num].B}}
                                </el-radio>
                                <el-radio
                                        :disabled="C"
                                        label="C">
                                    <span style="font-weight: 600;">C、</span>{{que_list[num].C}}
                                </el-radio>
                                <el-radio
                                        :disabled="D"
                                        label="D">
                                    <span style="font-weight: 600;">D、</span>{{que_list[num].D}}
                                </el-radio>
                            </el-radio-group>
                        </el-form-item>
                    </el-form>
                    <br>
                    <span style="position: absolute;top: 120px;left: 0px">结果:
                    <el-button type="danger" size="mini">{{que_list[num].user_answer}}</el-button></span>
                    <br>
                    <br>
                    <p style="position: absolute;top: 155px">分值:{{que_list[num].score}}</p>
                    <br>
                    <br>
                    <p style="position: absolute;top: 190px">难度:</p>
                    <el-rate style="position: absolute;top: 190px;left: 40px"
                             v-model="que_list[num].level"
                             disabled
                             text-color="#ff9900"
                             score-template="{value}">
                    </el-rate>
                    <br>
                    <br>
                    <p style="position: absolute;top: 225px">解析:{{que_list[num].analysis}}</p>
                    <br>
                    <br>
                    <span style="position: absolute;top: 260px;left: 0px">正确答案:
                    <el-button type="success" size="mini">{{que_list[num].show_answer}}</el-button></span>
                    <br>
                    <br>
                </div>
            </el-card>
        </el-col>
    </div>
</template>

<script>
    import Header from "../../components/Home/Header";

    export default {
        name: "index",
        data() {
            return {
                A: true,
                B: true,
                C: true,
                D: true,
                que_list: [],
                num: 0,
                choice: '',
                dialogImageUrl: '',
                dialogVisible: false,
                disabled: false,
                filter: {
                    page_size: 5,       // 单页数据量
                    page: 1,
                },
                tableData: [],
            }
        },
        components: {
            Header,
        },
        watch: {
            "filter.page_size": function () {
                this.get_paper_record();
            },
            "filter.page": function () {
                this.get_paper_record();
            },
        },
        created() {
            this.$http({
                url: this.$settings.base_url + '/api/student/wrong_que_list/?user_id=' + this.$cookies.get('user_id'),
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                // console.log(data.data.results[0].que_user_answer)
                this.count = data.data.count
                this.choice = data.data.results[0].que_user_answer
                if (this.choice === 'A') {
                    this.A = false
                } else if (this.choice === 'B') {
                    this.B = false
                } else if (this.choice === 'C') {
                    this.C = false
                } else if (this.choice === 'D') {
                    this.D = false
                }
                for (let obj in data.data.results) {
                    this.tableData.push({
                        id: obj,
                        answer: data.data.results[obj].que_user_answer,
                        title: data.data.results[obj].que_title,
                        pro_type: data.data.results[obj].que_type,
                        project: data.data.results[obj].que_course,
                        time: this.$settings.show_time(data.data.results[obj].que_time),
                    })
                    this.que_list.push(data.data.results[obj].que_detail)
                }
            })
        },
        methods: {
            click(data) {
                this.num = data.id
                this.choice = data.answer
                if (data.answer === 'A') {
                    this.A = false
                    this.B = true
                    this.C = true
                    this.D = true
                } else if (data.answer === 'B') {
                    this.B = false
                    this.A = true
                    this.C = true
                    this.D = true
                } else if (data.answer === 'C') {
                    this.C = false
                    this.B = true
                    this.A = true
                    this.D = true
                } else if (data.answer === 'D') {
                    this.D = false
                    this.C = true
                    this.B = true
                    this.A = true
                }
            },
            handleSizeChange(val) {
                // 每页数据量发生变化时执行的方法
                this.filter.page = 1;
                this.filter.page_size = val;
            },
            handleCurrentChange(val) {
                // 页码发生变化时执行的方法
                this.filter.page = val;
            },
            get_paper_record() {
                let filters = {};
                // 设置单页数据量
                if (this.filter.page_size > 0) {
                    filters.page_size = this.filter.page_size;
                } else {
                    filters.page_size = 5;
                }
                // 设置当前页码
                if (this.filter.page > 1) {
                    filters.page = this.filter.page;
                } else {
                    filters.page = 1;
                }

                this.$http({
                    url: this.$settings.base_url + '/api/student/wrong_que_list/?user_id=' + this.$cookies.get('user_id'),
                    method: 'get',
                    params: filters,
                    headers: {
                        token: this.$cookies.get('token')
                    }
                }).then(data => {
                    this.tableData = []
                    this.count = data.data.count
                    for (let obj in data.data.results) {
                        this.tableData.push({
                            id: obj,
                            answer: data.data.results[obj].que_user_answer,
                            title: data.data.results[obj].que_title,
                            pro_type: data.data.results[obj].que_type,
                            project: data.data.results[obj].que_course,
                            time: this.$settings.show_time(data.data.results[obj].que_time),
                        })
                        this.que_list.push(data.data.results[obj].que_detail)
                    }
                })
            },
        }
    }
</script>

<style scoped>

</style>




