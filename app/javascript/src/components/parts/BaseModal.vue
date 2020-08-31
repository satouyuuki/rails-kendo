<template>
  <div class="mask" v-if="isShow" @click.self="close">
    <div class="m-card">
      <div class="close-icon" @click="close">
        <span class="close-icon__item"></span>
        <span class="close-icon__item"></span>
      </div>
      <h2>{{title}}</h2>
      <div>
        <slot />
      </div>
      <div class="m-card__bottom">
        <button type="button" class="close-btn" @click="close">閉じる</button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "BaseModal",
  props: [
    "title"
  ],
  data: () => {
    return {
      isShow: false,
    }
  },
  methods: {
    open() {
      this.isShow = true;
    },
    close() {
      this.isShow = false;
    },
  }
}
</script>
<style scoped lang="scss">
@import "../../scss/variable.scss";
.mask {
  display: block;
  position: absolute;
  background-color: rgba($black, .4);
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}
.m-card {
  width: 500px;
  height: auto;
  background: $white;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  &__bottom {
    display: flex;
    justify-content: center;
    min-height: 60px;
    align-items: center;
  }
  &__list {
    display: block;
    border-bottom: 1px solid $light-grey;
    &--img {
      width: 40px;
      height: auto;
    }
  }
}
.close-btn {
  background: $white;
  border: 1px solid $light-grey;
  color: $light-grey;
  border-radius: 20px;
  padding: 2px 20px;
  height: 30px;
  box-sizing: content-box;
  &:focus,
  &:hover {
    outline: none;
    border: 2px solid $light-grey;
  }
}
.close-icon {
  width: 20px;
  height: 20px;
  position: absolute;
  right: 10px;
  top: 10px;
  &__item {
    width: 100%;
    position: absolute;
    top: 50%;
    height: 2px;
    display: block;
    background: #000;
    &:nth-child(1) {
      transform: rotate(45deg);
    }
    &:nth-child(2) {
      transform: rotate(-45deg);
    }
  }
}
</style>