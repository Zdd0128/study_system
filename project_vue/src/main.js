import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.config.productionTip = false

// vuex


// 时间转换处理
// import dayjs from 'dayjs'
//
// Vue.prototype.dayjs = dayjs;

// 配置全局css样式
import './assets/css/global.css'


// 配置全局访问路由接口
import settings from './assets/js/settings'
// console.log(settings) --->  {base_url: "http://127.0.0.1:8000"}
// 把settings这个对象，放到Vue的原型中
Vue.prototype.$settings = settings

// axios的配置
import axios from 'axios'

Vue.prototype.$http = axios

//cookie的配置
import cookies from 'vue-cookies'

Vue.prototype.$cookies = cookies

// elementui配置
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

Vue.prototype.$EventBus = new Vue()
Vue.prototype.$EventBus_username = new Vue()


// 视频播放相关
// vue-video播放器
require('video.js/dist/video-js.css');
require('vue-video-player/src/custom-theme.css');
import VideoPlayer from 'vue-video-player'

Vue.use(VideoPlayer);


// 富文本编辑器
import VueQuillEditor from 'vue-quill-editor'

//引入富文本css
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'

// 富文本编辑器添加实例
Vue.use(VueQuillEditor, /* { default global options } */)


new Vue({
    el: '#app',
    router,
    store,
    render: h => h(App),
    components: {App},
    template: '<App/>'
})
