<template>
  <div class="mask" v-if="isShow" v-on:click.self="close">
    <div class="m-card">
      <button type="button" class="m-card__close-btn" v-on:click="close">閉じる</button>
      <h2>試合表を変更</h2>
      <div>
        ポジション: {{currentCell.position}}
        <label><input type="radio" v-model="checkTeam" value=1>自分</label>
        <label><input type="radio" v-model="checkTeam" value=2>相手</label>
        相手: {{currentCell.team_id}}
        自分: {{currentCell.opponent_id}}
      </div>
      <div v-for="item in currentCell.my_kimete" :key="item">
        自分のポイント<img :src="images[item]">
      </div>
      <div v-for="item in currentCell.aite_kimete" :key="item">
        相手のポイント<img :src="images[item]">
      </div>
      <div class="m-card__list">
        <span v-for="(item, index) in items" :key="index">
          <img :src="item.name" @click="onSelectImg(index, checkTeam)">
        </span>
      </div>
    </div>
  </div>
</template>
<script>
import men from '../../assets/images/men.svg'
import kote from '../../assets/images/kote.svg'
import dou from '../../assets/images/dou.svg'
export default {
  name: "hanteiModal",
  props: [
    'isHanteiModalShow'
  ],
  data: () => {
    return {
      isShow: false,
      checkTeam: 1,
      images: {
        0: men,
        1: kote,
        2: dou,
      },
      items: [
        {name: men},
        {name: kote},
        {name: dou},
      ],
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
    open(cell) {
      this.currentCell = cell;
      this.isShow = true;
    },
    close() {
      this.isShow = false;
    },
    onSelectImg(index, checkTeam) {
      this.$emit('selectImg', {index, checkTeam});
    }
  }
}
</script>