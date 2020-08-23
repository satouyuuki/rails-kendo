<template>
  <div>
    <router-link :to="{name: 'list'}">一覧ページ</router-link>
    <hanteiModal 
      :isHanteiModalShow="isHanteiModalShow"
      @toggleHanteiShow="toggleHanteiShow"
      @selectImg="selectImg"
    />
    <memberModal 
      :isMemberModalShow="isMemberModalShow"
      @toggleMemberShow="toggleMemberShow"
      @decisionMember="decisionMember"
    />
    <opponentModal 
      :isOpponentModalShow="isOpponentModalShow"
      @toggleOpponentShow="toggleOpponentShow"
      @decisionOpponent="decisionOpponent"
    />
    <h1>試合表</h1>
    <span>2020/8/6(水)</span>
    <button type="button" class="print" onclick="window.print();">印刷</button>
    <button type="button" class="member" v-on:click="toggleMemberShow">メンバー編成</button>
    <button type="button" class="member" v-on:click="toggleOpponentShow">相手チーム</button>
    <button type="button" v-on:click="createLog">作成</button>
    <div class="match-table">
      <!-- 自分のチーム -->
      <teams 
        :members="regMembers"
      />
      <!-- 試合表 -->
      <masu 
        :cells="cells"
        @toggleHanteiShow="toggleHanteiShow"
      />
      <!-- 相手のチーム -->
      <teams 
        :members="oppMembers"
      />
      <div class="match-table__list">
        <div class="match-table__list--cell">自分の高校</div>
        <div class="match-table__list--cell">{{schoolName}}</div>
      </div>
    </div>
  </div>
</template>
<script>
import hanteiModal from '../home/hanteiModal.vue';
import memberModal from '../home/memberModal.vue';
import opponentModal from '../home/opponentModal.vue';
import masu from '../home/masu.vue';
import teams from '../home/teams.vue';
export default {
  components: {
    hanteiModal,
    memberModal,
    opponentModal,
    masu,
    teams,
  },
  name: "index",
  data: () => {
    return {
      isHanteiModalShow: false,
      isMemberModalShow: false,
      isOpponentModalShow: false,
      items: [],
      regMembers: [
        {team_id: 1, name: "", position: 1},
        {team_id: 2, name: "", position: 2},
        {team_id: 3, name: "", position: 3},
        {team_id: 4, name: "", position: 4},
        {team_id: 5, name: "", position: 5},
      ],
      oppMembers: [
        {opponent_id: 1, name: "", position: 1},
        {opponent_id: 2, name: "", position: 2},
        {opponent_id: 3, name: "", position: 3},
        {opponent_id: 4, name: "", position: 4},
        {opponent_id: 5, name: "", position: 5},
      ],
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
      masuId: 0,
      schoolName: "△△高校",
    }
  },
  computed: {
    customCells() {
      const matchID = this.$route.params.matchId;
      const result = [];
      const oddCell = this.cells.filter(item => item.id % 2 !== 0);
      const evenCell = this.cells.filter(item => item.id % 2 === 0);
      this.regMembers.forEach((item, index) => {
        const cloneRegMember = Object.assign({}, item);
        const cloneOppMember = Object.assign({}, this.oppMembers[index]);
        delete cloneRegMember.name;
        delete cloneOppMember.name;
        cloneRegMember['my_kimete'] = oddCell[index].items.join(',');
        cloneRegMember['aite_kimete'] = evenCell[index].items.join(',');
        cloneRegMember['match_id'] = Number(matchID);
        result.push(Object.assign(cloneRegMember, cloneOppMember));
      })
      // console.log(result);
      return result
    }
  },
  methods: {
    createLog() {
      fetch('api/logs', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify(this.customCells)
      })
      .then(res => res.json())
      .then(res => console.log(res))
      .catch(err => console.log(err));
    },
    toggleHanteiShow(id) {
      this.masuId = id;
      this.isHanteiModalShow = !this.isHanteiModalShow;
    },
    toggleMemberShow() {
      this.isMemberModalShow = !this.isMemberModalShow;
    },
    toggleOpponentShow() {
      this.isOpponentModalShow = !this.isOpponentModalShow;
    },
    selectImg(index) {
      const cell = this.cells
        .filter(cell => cell.id === this.masuId)
        .map(map => {
          map.items.push(index);
        });
    },
    decisionMember(members) {
      if(!members || members.length < 5) return;
      this.regMembers.map((map, index) => {
        map.team_id = members[index].id;
        map.name = members[index].name;
      })
    },
    decisionOpponent(members) {
      if(!members[1] || !members[0] || members[0].length < 5) return;
      this.oppMembers.map((map, index) => {
        map.opponent_id = members[0][index].id;
        map.name = members[0][index].name;
      })
      if(members[1]) this.schoolName = members[1];
    },
  },
  mounted() {
  }
}
</script>