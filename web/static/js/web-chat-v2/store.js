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
    channel: {
      room: null,
      self: null,
      dialog: null
    },
    main: {
      is_show: true,
      current_tab: "friend",
      friends: [],
      friend_selected: null,
      friend_selected_id: null,
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
    set_main_friends (state, friends) {
      state.main.friends = friends
    },
    set_main_friend_selected (state, user) {
      state.main.friend_selected = user
      state.main.friend_selected_id = user.id
    },
    set_main_current_tab (state, name) {
      state.main.current_tab = name
    }
  }
})

export default store
