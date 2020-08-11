<template>
  <div class="mask" v-if="isShow" v-on:click.self="onToggleShow">
    <div class="m-card">
      <button type="button" class="m-card__close-btn" v-on:click="onToggleShow">閉じる</button>
      <h2>試合表を変更</h2>
      <div class="m-card__list">
        <!-- <img src="/app/javascript/src/assets/images/men.svg" alt="">
        <img src="/app/javascript/src/assets/images/sankaku.svg" alt="">
        <img src="/app/javascript/src/assets/images/ippon.svg" alt=""> -->
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "modal",
  props: [
    'isShow'
  ],
  methods: {
    onToggleShow() {
      this.$emit('toggleShow');
    }
  }
}
</script>