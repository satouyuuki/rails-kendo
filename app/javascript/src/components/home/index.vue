<template>
  <div>
    <modal 
      v-bind:isShow="isShow" 
      @toggleShow="toggleShow"
    />
    <h1>試合表</h1>
    <span>2020/8/6(水)</span>
    <button type="button" class="print" onclick="window.print();">印刷</button>
    <div class="match-table">
      <div class="match-table__list">
        <div class="match-table__list--cell">佐藤</div>
        <div class="match-table__list--cell2" v-on:click="toggleShow">
          <!-- <%= image_tag 'men.svg', class: 'match-table__icon' %>
          <%= image_tag 'men.svg', class: 'match-table__icon' %> -->
          <img src="" alt="">
        </div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">田中</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">鈴木</div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">武藤</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">鈴木</div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">武藤</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">鈴木</div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">武藤</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">鈴木</div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">武藤</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">○○高校</div>
        <div class="match-table__list--cell">△△高校</div>
      </div>
    </div>
  </div>
</template>
<script>
import modal from './modal.vue';
export default {
  components: {
    modal,
  },
  name: "index",
  data: () => {
    return {
      member: 5,
      isShow: false,
    }
  },
  methods: {
    toggleShow() {
      this.isShow = !this.isShow;
    }
  }
}
</script>