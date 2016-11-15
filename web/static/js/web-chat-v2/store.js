import Vue from "vue"
import Vuex from "vuex"
import socket from "./socket"
import Tool from "./tool"
import List from "./struct/list"
import NotificationDialog from "./struct/notification_dialog"

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
        left: new List(new Set()),
        right: {
          data: []
        }
      },
      notification: {
        dialog: new NotificationDialog(),
        firend: [],
        system: [],
      }
    },
  },
  mutations: {
    close_main (state) {
      state.is_mini = true
    },
    open_main (state, tab) {
      state.is_mini = false

      if (tab) {
        state.main.current_tab = tab
      }
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
    push_main_friend_left_data (state, data) {
      state.main.friend.left.data.splice(0, 0, data)
    },
    set_main_friend_left_selected (state, item) {
      state.main.friend.left.selected = item
    },
    set_main_current_tab (state, name) {
      state.main.current_tab = name
    },
    open_dialog (state, item) {
      state.is_mini = false
      state.main.current_tab = "dialog"
      state.main.dialog.left.add(item)
      state.main.dialog.left.selected(item)
    },
    set_main_dialog_left_selected (state, item) {
      state.main.dialog.left.selected(item)

      if (item) {
        state.main.notification.dialog.reset_statistics(item.id)
      }
    },
    remove_main_dialog_left_data (state, item) {
      state.main.dialog.left.delete(item)
    },
    set_main_dialog_right_data (state, data) {
      state.main.dialog.right.data = data
    },
    push_main_dialog_right_data (state, item) {
      state.main.dialog.right.data.push(item)
    },

    reset_notification_dialog (state) {
      state.main.notification.dialog.reset()
    },
    reset_notification_dialog_total (state) {
      state.main.notification.dialog.reset_total()
    },
    reset_notification_dialog_statistics (state, key) {
      state.main.notification.dialog.reset_statistics(key)
    },

    set_notification_dialog (state, data) {
      data.map(function(item) {
        state.main.notification.dialog.add(item)
        state.main.dialog.left.add(item.user)
      })
    },
    push_notification_dialog (state, data) {
      state.main.notification.dialog.add(data)
      state.main.dialog.left.add(data.user)
    },
  }
})

export default store
