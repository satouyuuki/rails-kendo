<template>
  <div class="masu-list">
    <div class="masu-list__cells">
      <div 
      v-for="(cell, index) in cells"
      :key="index"
      class="masu-list__cell"
      v-on:click="openHanteiModal(cell)"
      >
        <div class="masu-list__item">
          <div v-for="(myitem, index) in cell.my_kimete" :key="index" class="point-icon">
            <img :src="images[myitem]" class="point-icon__img">
          </div>
        </div>
        <div class="masu-list__item">
          <div v-for="(aiteitem, index) in cell.aite_kimete" :key="index" class="point-icon">
            <img :src="images[aiteitem]" class="point-icon__img">
          </div>          
        </div>
      </div>
    </div>
    <hanteiModal 
      ref="hanteiRef"
      @selectImg="selectImg"
      @deletePoint="deletePoint"
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
    'cells',
    'viewType'
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
      if(this.viewType !== 'detail') {
        this.$refs.hanteiRef.open(cell);
        this.$emit('toggleHanteiShow', cell.position);
      }
    },
    selectImg(val) {
      this.$emit('selectImg', val);
    },
    deletePoint(val) {
      this.$emit('deletePoint', val);
    }
  }
}
</script>
<style lang="scss" scoped>
@import "../../scss/variable.scss";
.masu-list {
  display: flex;
  &__cells {
    display: flex;
    flex-wrap: wrap;
    width: 300px;
  }
  &__cell {
    display: flex;
    width: 100%;
    background-color: $light-grey;
    min-height: 70px;
    border: 1px solid $grey;
  }
  &__item {
    width: 50%;
    &:first-child {
      border-right: 1px solid $grey;
    }
  }
}
</style>