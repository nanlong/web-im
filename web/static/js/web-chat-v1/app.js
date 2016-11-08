import Vue from "vue"
import Vuex from "vuex"
import date from "./filters/date"
import App from "./components/App.vue"
import ChatButton from "./components/Button.vue"
import socket from "./socket"

Vue.use(Vuex)
Vue.filter("date", date)

let room_channel = socket.channel("room:lobby", {})

room_channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

// 共享数据
const store = new Vuex.Store({
  state: {
    current_user: zheye.config.webchat,
    socket: socket,
    channel: {
      room: room_channel,
      dialog: null,
      self: null,
    },
    main: {
      is_mini: true,
      firends: [],
    },
    dialog: {
      is_open: false,
      user_list: [],
      user_list_id: [],
      current_user: {},
    },
    message: {
      is_open: false,
      data: null,
    },
  },
  mutations: {
    set_current_user (state, user) {
      state.current_user = user
    },
    toggle_mini (state) {
      state.main.is_mini = !state.main.is_mini
    },
    open_dialog (state) {
      state.dialog.is_open = true
    },
    close_dialog (state) {
      state.dialog.is_open = false
    },
    push_dialog_user_list (state, user) {
      if (state.dialog.user_list_id.indexOf(user.id) < 0) {
        state.dialog.user_list.push(user)
        state.dialog.user_list_id.push(user.id)
      }

      state.dialog.current_user = user
    },
    remove_dialog_user_list (state, user) {
      let index = state.dialog.user_list_id.indexOf(user.id)

      if (state.dialog.current_user.id == user.id) {
        state.dialog.current_user = {}
      }

      if (index > -1) {
        state.dialog.user_list.splice(index, 1)
        state.dialog.user_list_id.splice(index, 1)
      }
    },
    set_dialog_channel (state, channel) {
      state.channel.dialog = channel
    },
    set_self_channel (state, channel) {
      state.channel.self = channel
    },
    open_message (state, data) {
      state.message.is_open = true
      state.message.data = data
    },
    close_message (state) {
      state.message.is_open = false
    },
    set_firends (state, data) {
      state.main.firends = data
    }
  }
})

// 初始化app
new Vue({
  el: "#zheye-web-chat",
  store,
  render: h => h(App)
})

// 初始化button
document.querySelectorAll('.zheye-web-chat-button').forEach(function(element) {
  new Vue({
    el: element,
    store,
    components: {
      ChatButton
    }
  })
})
