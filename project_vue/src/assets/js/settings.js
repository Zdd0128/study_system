import dayjs from "dayjs";

export default {
    // base_url: 'http://101.91.213.1:8001',
    base_url: 'http://127.0.0.1:8000',
    video_url: 'http://101.91.213.1:9090/video/',
    movies_url: 'http://101.91.213.1:9090/video/movies_img/',

    // 时间
    show_time(time) {
        time = this.formateDate(time);	// 2020-09-30 2:2:2
        return time
    },

    // 时间格式转换
    formateDate(time) {

        // 使用dayjs 把世界标准时间转换为北京时间
        let date = dayjs(time).format();

        // 把2020-09-30T02:02:02+08:00 截取出 '2020-9-30 2:2:2'
        const arr = date.split("T");
        const d = arr[0];
        const darr = d.split("-");

        const t = arr[1];
        const tarr = t.split("+");
        const marr = tarr[0].split(":");

        const dd =
            parseInt(darr[0]) +
            "-" +
            parseInt(darr[1]) +
            "-" +
            parseInt(darr[2]) +
            " " +
            parseInt(marr[0]) +
            ":" +
            parseInt(marr[1]) +
            ":" +
            parseInt(marr[2]);

        return dd;
    },

    // 当天零点倒计时
    count_down(time) {
        //延迟一秒执行自己
        var iCount = setInterval(function () {
            //结束时间
            var endDate = new Date(time);
            //当前时间
            var nowDate = new Date();
            //相差的总秒数
            var totalSeconds = parseInt((endDate - nowDate) / 1000);
            //关闭定时器
            if (totalSeconds <= 0) {
                clearInterval(iCount);
                localStorage.clear()
                return;
            }
            //天数
            var days = Math.floor(totalSeconds / (60 * 60 * 24));
            //取模（余数）
            var modulo = totalSeconds % (60 * 60 * 24);
            //小时数
            var hours = Math.floor(modulo / (60 * 60));
            modulo = modulo % (60 * 60);
            //分钟
            var minutes = Math.floor(modulo / 60);
            //秒
            var seconds = modulo % 60;
            var t = days < 10 ? '0' + days.toString() : days;
            var s = hours < 10 ? '0' + hours.toString() : hours;
            var f = minutes < 10 ? '0' + minutes.toString() : minutes;
            var m = seconds < 10 ? '0' + seconds.toString() : seconds;
            var remaining_time = "距离结束还剩:" + s + "小时" + f + "分钟" + m + "秒";
            $('#time').html(remaining_time)
        }, 1000)
    },

    // 系统时间展示
    time() {
        var now_time = setInterval(function () {

            var vWeek, vWeek_s, vDay;
            vWeek = ["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
            var date = new Date();
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var seconds = date.getSeconds();
            vWeek_s = date.getDay();
            var time_now = hours + ":" + minutes + ":" + seconds + "\t" + vWeek[vWeek_s];
            $('#now_time').html(time_now)
        }, 1000)
    },
}
