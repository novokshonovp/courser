<template>
  <div id="rate">
    <div id="rate_text">
      {{ currency }}: {{ rate}}
    </div>
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
      update_rate: function(data) {
        this.currency = data.currency_sign;
        this.rate = data.rate;
      }
    },
  mounted: function() {
    this.$parent.$on('update', this.update_rate);
  }
}
</script>

<style scoped>
#rate_text {
  font-size: 4em;
  text-align: center;
}
</style>
