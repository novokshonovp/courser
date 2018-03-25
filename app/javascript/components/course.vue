<template>
  <div id="app">
    <p>{{ currency }}: {{ rate}} </p>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      currency: gon.currency,
      rate: gon.rate
    }
  },
  methods: {
      update_course: function(data) {
        this.currency = data.currency_sign;
        this.rate = data.rate;
      }
    },
  created: function() {
    this.$parent.$on('update', this.update_course);
  }
}
</script>

<style scoped>
p {
  font-size: 4em;
  text-align: center;
}
</style>
