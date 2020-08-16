<template>
  <div class="match-table__cells">
    <div 
    v-for="cell in cells"
    :key="cell.id"
    class="match-table__cells--item" 
    v-on:click="openHanteiModal(cell.id)"
    >
      <div v-for="item in cell.items" :key="item" class="match-table__icon">
        <img :src="images[item]">
      </div>
    </div>
  </div>
</template>
<script>
import men from '../../assets/images/men.svg'
import kote from '../../assets/images/kote.svg'
import dou from '../../assets/images/dou.svg'

export default {
  name: "masu",
  props: [
    'cells'
  ],
  data() {
    return {
      images: {
        0: men,
        1: kote,
        2: dou,
      },
    }
  },
  methods: {
    openHanteiModal(id) {
      this.$emit('toggleHanteiShow', id);
    }
  }
}
</script>