import Vue from "vue"
import Vuex from "vuex"
import socket from "./socket"

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    socket: socket,
    current_user: zheye.config.webchat,
    main: {
      is_show: true,
    },
    mini: {
      is_show: false,
    }
  },
  mutations: {
    close_main (state) {
      state.main.is_show = false
      state.mini.is_show = true
    },
    open_main (state) {
      state.main.is_show = true
      state.mini.is_show = false
    }
  }
})

export default store
