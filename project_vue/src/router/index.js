import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home'
import Retrieve_pwd from "../views/Retrieve_pwd";
import Email_editor_pwd from "../views/Email_editor_pwd";
import Login from "../views/login/index";
import Register from "../views/register/index";
import Video from '../views/video/index'
import Paper from '../views/paper/index'
import Record from '../views/record/index'
import Question from '../views/question/index'
import UserInfo from '../views/userinfo/index'
import Task from "../components/Task Center/Task";
import Basics_Paper from "../components/Task Center/Basics_Paper";
import Senior_paper from "../components/Task Center/Senior_paper";
import PaySuccess from "../views/paysuccess/index"
import Course_detail from "../views/video/course_detail"
import Movie_video from "../views/video/movie_video"

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name: '',
        component: Login
    },
    {
        path: '/login',
        name: '',
        component: Login
    },
    {
        path: '/register',
        name: '',
        component: Register
    },
    {
        path: '/home',
        name: '',
        component: Home
    },
    {
        path: '/home/task',
        name: '',
        component: Task
    },
    {
        path: '/home/basics_paper',
        name: '',
        component: Basics_Paper
    },
    {
        path: '/home/senior_paper',
        name: '',
        component: Senior_paper
    },
    {
        path: '/home/video',
        name: '',
        component: Video
    },
    {
        path: '/home/paper',
        name: '',
        component: Paper
    },
    {
        path: '/home/record',
        name: '',
        component: Record
    },
    {
        path: '/home/question',
        name: '',
        component: Question
    },
    {
        path: '/user/:username',
        name: '',
        component: UserInfo
    },
    {
        path: '/Retrieve_pwd',
        name: '',
        component: Retrieve_pwd
    },
    {
        path: '/Email_editor_pwd',
        name: '',
        component: Email_editor_pwd
    },

    {
        path: '/pay/success',
        name: '',
        component: PaySuccess
    },
    {
        path: '/home/video/course_detail/:pk',
        name: '',
        component: Course_detail
    },

    {
        path: '/home/video/movie/:url',
        name: '',
        component: Movie_video
    },


]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})

import cookies from 'vue-cookies'

router.beforeEach((to, from, next) => {
    let token = cookies.get('token')
    if (to.path === '/login' || to.path === '/' || to.path === '/register' || to.path === '/Retrieve_pwd' || to.path === '/Email_editor_pwd') {
        next()
    } else {
        if (token === '' || token === null) {
            next('/login');
        } else {
            next()
        }
    }
})

export default router
