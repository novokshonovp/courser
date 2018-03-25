/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'courser_vue' %> (and
// <%= stylesheet_pack_tag 'courser_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.

import Vue from 'vue/dist/vue.esm'
import Course from '../components/course.vue'

document.addEventListener('DOMContentLoaded', () => {
  App.vue = new Vue({
    el: '#course',
    methods: {
        receiveMessage: function(data) {
          this.$emit('update', data);
        }
      },
    components: { Course }
  })
})
