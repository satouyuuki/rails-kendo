<template>
  <div class="match-table__cells">
    <div 
    v-for="cell in cells"
    :key="cell.id"
    class="match-table__cells--item" 
    v-on:click="openHanteiModal(cell.id)"
    >
      <div v-for="item in cell.items" :key="item" class="match-table__icon">
        <img :src="item">
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "masu",
  props: [
    'cells'
  ],
  methods: {
    openHanteiModal(id) {
      this.$emit('toggleHanteiShow', id);
    }
  }
}
</script>