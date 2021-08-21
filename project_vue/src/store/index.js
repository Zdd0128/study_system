import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const state = {
    count: 0,
}

const mutations = {
    mutationsAddCount(state, n = 0) {
        return (state.count += n)
    },
    mutationsReduceCount(state, n = 0) {
        return (state.count -= n)
    },
    // add_count(state, n) {
    //     return (state.count += n)
    // },
    // is_show(state, data) {
    //     return (state.show = data)
    // },
    // paper_show(state, data) {
    //     return (state.paper_show = data)
    // },
}

const actions = {
    actionsAddCount(context, n = 0) {

        return context.commit('mutationsAddCount', n)
    },
    actionsReduceCount({commit}, n = 0) {
        return commit('mutationsReduceCount', n)
    }
}


export default new Vuex.Store({
    state,
    mutations,
    actions,

    modules: {},
})



