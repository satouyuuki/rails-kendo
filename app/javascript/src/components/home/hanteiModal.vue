<template>
  <BaseModal 
    ref="BaseModalRef"
    title="試合表を変更"
  >
    <div>
      <div class="position-text">
        {{setPosition}}
      </div>
      <div class="selected-team">
        <div class="selected-team__item">
          <input type="radio" v-model="checkTeam" value=1 id="team">
          <label for="team">自分</label>          
        </div>
        <div class="selected-team__item">
          <input type="radio" v-model="checkTeam" value=2 id="opponent">
          <label for="opponent">相手</label>
        </div>
      </div>
    </div>
    <div class="point-area">
      <div class="point-area__item">
        <p>自分のポイント</p>
        <div v-for="(item, index) in currentCell.my_kimete" :key="index" class="point-icon">
          <img :src="trush" alt="ゴミ箱" @click="onDeletePoint(item, 1)" class="point-icon__del">
          <img :src="images[item]" class="point-icon__img">
        </div>
      </div>
      <div class="point-area__item">
        <p>相手のポイント</p>
        <div v-for="(item, index) in currentCell.aite_kimete" :key="index" class="point-icon">
          <img :src="trush" alt="ゴミ箱" @click="onDeletePoint(item, 2)" class="point-icon__del">
          <img :src="images[item]" class="point-icon__img">
        </div>
      </div>
    </div>
    <div class="m-card__list">
      <p>ポイント一覧</p>
      <span v-for="(item, index) in images" :key="index">
        <img :src="item" @click="onSelectImg(index)">
      </span>
    </div>
  </BaseModal>
</template>
<script>
import trush from '../../assets/images/trush.svg';
import BaseModal from '../parts/BaseModal';
import {teamMap} from '../../constant';
const positionMap = {
  1: '先鋒',
  2: '次鋒',
  3: '中堅',
  4: '副将',
  5: '大将'
};
export default {
  name: "hanteiModal",
  components: {
    BaseModal
  },
  props: [
    "images"
  ],
  data: () => {
    return {
      checkTeam: 1,
      trush: trush,
      currentCell: {
        position: 0,
        my_kimete: [],
        aite_kimete: []
      }
    }
  },
  computed: {
    setPosition() {
      return positionMap[this.currentCell.position];
    },
    getUnCheckedTeam() {
      return this.checkTeam == 1 ? 2 : 1;
    }
  },
  methods: {
    open(cell) {
      this.$refs.BaseModalRef.open();
      this.currentCell = cell;
    },
    onSelectImg(index) {
      // 自分が0で相手が2以下の時
      // 自分が1で相手が1以下の時
      if(
        this.currentCell[teamMap[this.checkTeam]].length === 0 && 
        this.currentCell[teamMap[this.getUnCheckedTeam]].length <= 2 ||
        this.currentCell[teamMap[this.checkTeam]].length === 1 && 
        this.currentCell[teamMap[this.getUnCheckedTeam]].length <= 1
      ) {
        const data = {
          index: index,
          checkTeam: this.checkTeam
        }
        this.$emit('selectImg', data);
      }
    },
    onDeletePoint(item, checkTeam) {
      this.$emit('deletePoint', {item, checkTeam});
    }
  },
}
</script>
<style scoped lang="scss">
.position-text {
  text-align: center;
  font-size: 2rem;
}
input[type=radio] {
  display: none;
}
input[type=radio]:checked + label {
  background: #31A9EE;
  color: #ffffff;
}
input[type=radio] + label {
  color: #000;
  width: 100%;
  height: 100%;
  text-align: center;
  margin: 0;
}
.selected-team {
  display: flex;
  min-height: 60px;
  line-height: 60px;
  &__item {
    width: 50%;
    height: auto;
  }
}
.point-area {
  display: flex;
  min-height: 60px;
  &__item {
    width: 50%;
    height: auto;
  }
}
</style>