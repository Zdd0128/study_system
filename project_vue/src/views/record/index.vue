<template>
    <div>
        <Header></Header>
        <el-row style="margin-top: 60px">
            <el-col :span='14' style="margin-left: 90px">
                <el-card class="box-card">
                    <el-table
                            :cell-style="cellStyle1"
                            :data="tableData_paper"
                            stripe
                            style="width: 100%">
                        <el-table-column
                                label="序号"
                                prop="paper_num"
                                width="120">
                        </el-table-column>
                        <el-table-column
                                label="试卷名称"
                                prop="paper_name"
                                width="240">
                        </el-table-column>
                        <el-table-column
                                label="试卷适合专业"
                                prop="paper_type"
                                width="180">
                        </el-table-column>
                        <el-table-column
                                label="提交时间"
                                prop="paper_time"
                                width="220">
                        </el-table-column>
                        <el-table-column
                                label="状态"
                                prop="paper_state"
                                width="80">
                        </el-table-column>
                    </el-table>
                </el-card>
                <div class="course_pagination block">
                    <el-pagination
                            @size-change="handleSizeChange"
                            @current-change="handleCurrentChange"
                            :current-page.sync="filter.page"
                            :page-sizes="0"
                            :page-size="filter.page_size"
                            layout="prev, pager, next"
                            :total="count">
                    </el-pagination>
                </div>
            </el-col>
        </el-row>
        <br>
        <br>
        <br>
        <el-row style="margin-top: -30px">
            <el-col :span='14' style="margin-left: 90px">
                <el-card class="box-card">
                    <el-table
                            :cell-style="cellStyle"
                            :data="tableData_task"
                            stripe
                            style="width: 100%">
                        <el-table-column
                                label="序号"
                                prop="task_num"
                                width="120">
                        </el-table-column>
                        <el-table-column
                                label="任务名称"
                                prop="task_name"
                                width="240">
                        </el-table-column>

                        <el-table-column
                                label="任务类型"
                                prop="task_type"
                                width="180">
                        </el-table-column>
                        <el-table-column
                                label="提交时间"
                                prop="task_time"
                                width="220">
                        </el-table-column>
                        <el-table-column
                                label="状态"
                                prop="task_state"
                                width="80">
                        </el-table-column>
                    </el-table>
                </el-card>
                <el-pagination
                        style="margin-top: 20px;"
                        @size-change="handleSizeChange1"
                        @current-change="handleCurrentChange1"
                        :current-page.sync="filter1.page"
                        :page-sizes="0"
                        :page-size="filter1.page_size"
                        layout="prev, pager, next"
                        :total="count1">
                </el-pagination>
            </el-col>
            <el-col style="position: fixed;top: 100px;left: 1000px" :span='6' :offset="1">
                <div class="day_day">
                    <el-calendar v-model="value">
                    </el-calendar>
                </div>
            </el-col>

        </el-row>

    </div>
</template>
<script>

    import Header from "../../components/Home/Header";

    export default {
        name: "index",
        components: {
            Header,
        },
        data() {
            return {
                value: new Date(),
                task_list: [],
                tableData_task: [],
                tableData_paper: [],
                count: 0,
                count1: 0,
                filter: {
                    page_size: 5,       // 单页数据量
                    page: 1,
                },
                filter1: {
                    page_size: 2,       // 单页数据量
                    page: 1,
                }
            }
        },
        watch: {
            "filter.page_size": function () {
                this.get_paper_record();
            },
            "filter.page": function () {
                this.get_paper_record();
            },
            "filter1.page_size": function () {
                this.get_task_record();
            },
            "filter1.page": function () {
                this.get_task_record();
            }
        },
        created() {
            this.$http({
                url: this.$settings.base_url + '/api/student/task_record/?user_id=' + this.$cookies.get('user_id'),
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                this.task_list = data.data.results
                this.count1 = data.data.count
                for (let task of data.data.results) {
                    if (task.get_state === '完成') {
                        var res = task.task_score + '分'
                    } else {
                        var res = task.get_state
                    }
                    this.tableData_task.push({
                            task_num: task.id,
                            task_name: task.get_task_name,
                            task_type: task.get_task_type,
                            task_time: this.$settings.show_time(task.create_time),
                            task_state: res
                        },
                    )
                }
            })

            this.$http({
                url: this.$settings.base_url + '/api/student/paper_record/?user_id=' + this.$cookies.get('user_id'),
                method: 'get',
                headers: {
                    token: this.$cookies.get('token')
                }
            }).then(data => {
                this.task_list = data.data.results
                this.count = data.data.count
                for (let paper of data.data.results) {
                    if (paper.get_state === '完成') {
                        var res = paper.paper_score + '分'
                    } else {
                        var res = paper.get_state
                    }
                    this.tableData_paper.push({
                        paper_num: paper.id,
                        paper_name: paper.get_paper_name,
                        paper_type: paper.get_paper_type,
                        paper_time: this.$settings.show_time(paper.create_time),
                        paper_state: res
                    },)
                }
            })
        },

        methods: {
            cellStyle(row, column, rowIndex, columnIndex) {
                this.create
                if (row.column.label === "状态" && row.row.task_state === "待批改") {
                    return 'color:#ff7706'
                } else if (row.column.label === "状态" && row.row.task_state !== "完成") {
                    return 'color:#0cd21d'
                }
            },
            cellStyle1(row, column, rowIndex, columnIndex) {
                if (row.column.label === "状态" && row.row.paper_state === "待批改") {
                    return 'color:#ff7706'
                } else if (row.column.label === "状态" && row.row.paper_state !== "完成") {
                    return 'color:#0cd21d'
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
            handleSizeChange1(val) {
                // 每页数据量发生变化时执行的方法
                this.filter1.page = 1;
                this.filter1.page_size = val;
            },
            handleCurrentChange1(val) {
                // 页码发生变化时执行的方法
                this.filter1.page = val;
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
                    url: this.$settings.base_url + '/api/student/paper_record/?user_id=' + this.$cookies.get('user_id'),
                    method: 'get',
                    params: filters,
                    headers: {
                        token: this.$cookies.get('token')
                    }
                }).then(data => {
                    this.tableData_paper = []
                    this.task_list = data.data.results
                    console.log(data)
                    for (let paper of data.data.results) {
                        if (paper.get_state === '完成') {
                            var res = paper.paper_score + '分'
                        } else {
                            var res = paper.get_state
                        }
                        this.tableData_paper.push({
                            paper_num: paper.id,
                            paper_name: paper.get_paper_name,
                            paper_type: paper.get_paper_type,
                            paper_time: this.$settings.show_time(paper.create_time),
                            paper_state: res
                        },)
                    }
                })
            },
            get_task_record() {
                let filters = {};
                // 设置单页数据量
                if (this.filter1.page_size > 0) {
                    filters.page_size = this.filter.page_size;
                } else {
                    filters.page_size = 2;
                }
                // 设置当前页码
                if (this.filter1.page > 1) {
                    filters.page = this.filter1.page;
                } else {
                    filters.page = 1;
                }
                this.$http({
                    url: this.$settings.base_url + '/api/student/task_record/?user_id=' + this.$cookies.get('user_id'),
                    method: 'get',
                    params: filters,
                    headers: {
                        token: this.$cookies.get('token')
                    }
                }).then(data => {
                        this.tableData_task = []
                        this.task_list = data.data.results
                        for (let task of data.data.results) {
                            this.tableData_task.push({
                                    task_num: task.id,
                                    task_name: task.get_task_name,
                                    task_type: task.get_task_type,
                                    task_time: this.$settings.show_time(task.create_time),
                                    task_state: task.get_state
                                },
                            )
                        }
                    }
                )
            }
        }
    }
</script>

<style scoped>

</style>







