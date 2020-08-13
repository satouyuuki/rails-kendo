<template>
  <div>
    <modal 
      v-bind:isShow="isShow" 
      @toggleShow="toggleShow"
    />
    <h1>試合表</h1>
    <span>2020/8/6(水)</span>
    <button type="button" class="print" onclick="window.print();">印刷</button>
    <div v-for="team in teams" :key="team.id">
      {{team.name}}
    </div>
    <div class="match-table">
      <div class="match-table__list">
        <div class="match-table__list--cell">佐藤</div>
        <div class="match-table__list--cell2" v-on:click="toggleShow">
          <img :src="men" alt="">

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
import men from '../../assets/images/men.svg'
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
      men: men,
      teams: [],
    }
  },
  methods: {
    toggleShow() {
      this.isShow = !this.isShow;
    }
  },
  mounted() {
    fetch('api/teams')
    .then(res => {
      return res.json();
    })
    .then(res => {
      this.teams = res;
    })
  }
}
</script>