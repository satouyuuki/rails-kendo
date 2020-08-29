<template>
  <router-link class="header" tag="div" :to="{name: 'list'}">KENDO-APP</router-link>
</template>
<script>
export default {
  name: 'Header',
}
</script>
<style scoped>
.header {
  font-size: 34px;
  text-align: center;
}
</style>