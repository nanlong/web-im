import Vue from "vue"
import Vuex from "vuex"
import socket from "./socket"
import Tool from "./tool"

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    socket: socket,
    domain: Tool.get_domain(),
    current_user: zheye.config.webchat,
    is_mini: true,
    channel: {
      room: null,
      self: null,
      dialog: null
    },
    main: {
      current_tab: "friend",
      friend: {
        left: {
          data: [],
          selected: null,
        }
      },
      dialog: {
        left: {
          data: [],
          selected: null,
        },
        right: {
          data: []
        }
      }
    },
  },
  mutations: {
    close_main (state) {
      state.is_mini = true
    },
    open_main (state) {
      state.is_mini = false
    },
    set_channel_room (state, channel) {
      state.channel.room = channel
    },
    set_channel_self (state, channel) {
      state.channel.self = channel
    },
    set_channel_dialog (state, channel) {
      state.channel.dialog = channel
    },
    set_main_friend_left_data (state, data) {
      state.main.friend.left.data = data
    },
    set_main_friend_left_selected (state, item) {
      state.main.friend.left.selected = item
    },
    set_main_current_tab (state, name) {
      state.main.current_tab = name
    },
    open_dialog (state, item) {
      let has_item = false
      state.main.current_tab = "dialog"
      state.main.dialog.left.selected = item

      state.main.dialog.left.data.map(function(_item) {
        if (item.id == _item.id) {
          has_item = true
          return
        }
      })

      if (!has_item) {
        state.main.dialog.left.data.splice(0, 0, item)
      }
    },
    set_main_dialog_left_selected (state, item) {
      state.main.dialog.left.selected = item
    },
    set_main_dialog_right_data (state, data) {
      state.main.dialog.right.data = data
    },
    push_main_dialog_right_data (state, item) {
      state.main.dialog.right.data.push(item)
    }
  }
})

export default store
