<template>
  <div>
    <div class="match-table__cells">
      <div 
      v-for="cell in cells"
      :key="cell.position"
      class="match-table__cell"
      v-on:click="openHanteiModal(cell)"
      >
        <div class="match-table__item">
          <div v-for="myitem in cell.my_kimete" :key="myitem" class="match-table__icon">
            <img :src="images[myitem]">
          </div>
        </div>
        <div class="match-table__item">
          <div v-for="aiteitem in cell.aite_kimete" :key="aiteitem" class="match-table__icon">
            <img :src="images[aiteitem]">
          </div>          
        </div>
      </div>
    </div>
    <hanteiModal 
      ref="hanteiRef"
      @selectImg="selectImg"
    />
  </div>
</template>
<script>
import hanteiModal from './hanteiModal.vue';
import men from '../../assets/images/men.svg'
import kote from '../../assets/images/kote.svg'
import dou from '../../assets/images/dou.svg'

export default {
  name: "masu",
  components: {
    hanteiModal
  },
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
      currentCell: {
        position: 0,
        team_id: 0,
        opponent_id: 0,
        my_kimete: [],
        aite_kimete: []
      }
    }
  },
  methods: {
    openHanteiModal(cell) {
      this.$refs.hanteiRef.open(cell);
      this.$emit('toggleHanteiShow', cell.position);
    },
    selectImg(val) {
      this.$emit('selectImg', val);
    }
  }
}
</script>