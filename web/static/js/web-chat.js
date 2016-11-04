import Vue from "vue"
import Vuex from "vuex"
import date from "./date"
import App from "./web-chat-components/App.vue"
import ChatButton from "./web-chat-components/Button.vue"
import socket from "./web-chat-socket"

Vue.use(Vuex)
Vue.filter("date", date)

let room_channel = socket.channel("room:lobby", {})

room_channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

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
      is_mini: false,
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

new Vue({
  el: "#zheye-web-chat",
  store,
  render: h => h(App)
})

const buttons = document.querySelectorAll('.zheye-web-chat-button')

buttons.forEach(function(el, index) {
  let ele_id = `zheye-web-chat-button-${index}`
  el.setAttribute("id", ele_id)

  new Vue({
    el: `#${ele_id}`,
    store,
    components: {
      ChatButton
    }
  })
})
