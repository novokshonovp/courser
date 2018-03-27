import { mount } from '@vue/test-utils'
import Vue from 'vue/dist/vue.esm'
import Rate from 'rate_render.vue'


global.gon = {
  'currency': 'USD',
  'rate': '55'
}

describe('rate_render.vue', () => {
  let clone, wrapper, app
  beforeEach(() => {
    clone = Vue.extend(Rate)
    app =   new Vue({
        methods: {
            receiveMessage: function(data) {
              this.$emit('update', data);
            }
          },
        components: {rate: Rate}
      })

    wrapper = new clone
    wrapper.$parent = app
    wrapper.$mount()
  })

  it('test data init', () => {
    expect(wrapper.currency).toEqual('USD')
    expect(wrapper.rate).toEqual('55')
  })

  it('test emit', () => {
    app.$emit('update', {'currency_sign':'USD', 'rate':'100'})
    expect(wrapper.rate).toEqual('100')
  })


})
