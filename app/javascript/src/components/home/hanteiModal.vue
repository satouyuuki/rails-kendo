<template>
  <div class="mask" v-if="isHanteiModalShow" v-on:click.self="onToggleShow">
    <div class="m-card">
      <button type="button" class="m-card__close-btn" v-on:click="onToggleShow">閉じる</button>
      <h2>試合表を変更</h2>
      <div class="m-card__list">
        <div v-for="(item, index) in items" :key="index">
          <img :src="item.name" @click="onTest(index)">
        </div>
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
      items: [
        {name: men},
        {name: kote},
        {name: dou},
      ],
    }
  },
  methods: {
    onToggleShow() {
      this.$emit('toggleHanteiShow');
    },
    onTest(index) {
      this.$emit('selectImg', index);
    }
  }
}
</script>