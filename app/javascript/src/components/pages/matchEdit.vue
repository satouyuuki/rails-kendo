<template>
  <div>  
    <!-- <hanteiModal 
      :isHanteiModalShow="isHanteiModalShow"
      @toggleHanteiShow="toggleHanteiShow"
      @selectImg="selectImg"
    />   -->
    <h1>試合結果</h1>
    <button>編集完了</button>
    <div>試合会場: {{place}}</div>
    <div class="match-table">
      <!-- 自分のチーム -->
      <teams :members="regMembers"/>
      <!-- 試合表 -->
      <masu :cells="cells"/>
      <!-- 相手のチーム -->
      <teams :members="oppMembers"/>
      <div class="match-table__list">
        <div class="match-table__list--cell">自分の高校</div>
        <div class="match-table__list--cell">{{schoolName}}</div>
      </div>
    </div>
  </div>

</template>
<script>
import hanteiModal from '../home/hanteiModal.vue';
import masu from '../home/masu.vue';
import teams from '../home/teams.vue';
export default {
  components: {
    hanteiModal,
    masu,
    teams,
  },
  data() {
    return {
      schoolName: '',
      place: '',
      regMembers: [],
      oppMembers: [],
      cells: [
        { id: 1, items: [] },
        { id: 2, items: [] },
        { id: 3, items: [] },
        { id: 4, items: [] },
        { id: 5, items: [] },
        { id: 6, items: [] },
        { id: 7, items: [] },
        { id: 8, items: [] },
        { id: 9, items: [] },
        { id: 10, items: [] },
      ],
    }
  },
  mounted() {
    fetch(`api/logs/${this.$route.params.matchId}`)
    .then(res => res.json())
    .then(res => {
      const oddCells = this.cells.filter(cell => cell.id % 2 !== 0);
      const evenCells = this.cells.filter(cell => cell.id % 2 === 0);
      this.schoolName = res[0].o_school;
      this.place = res[0].place;
      res.forEach((item, index) => {
        this.regMembers.push({
          team_id: item.team_id,
          name: item.t_name
          });
        this.oppMembers.push({
          opponent_id: item.opponent_id,
          name: item.o_name
          });
        oddCells[index].items = item.my_kimete.split(',');
        evenCells[index].items = item.aite_kimete.split(',');
      });
    })
  }
}
</script>