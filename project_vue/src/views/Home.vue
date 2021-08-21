<template>
    <div>
        <Header></Header>
        <Banner></Banner>
        <Task></Task>
        <Footer style="margin-top: 3%"></Footer>
    </div>
</template>

<script>
    import Header from "../components/Home/Header";
    import Footer from "../components/Home/Footer"
    import Banner from "../components/Home/Banner"
    import Task from "../components/Task Center/index"

    export default {
        name: 'Home',
        data() {
            return {}
        },
        components: {
            Header,
            Footer,
            Banner,
            Task,
        }
    }
</script>
<style>
    /*.footer {*/
    /*    position: fixed;*/
    /*    bottom: 0;*/
    /*}*/

</style>
