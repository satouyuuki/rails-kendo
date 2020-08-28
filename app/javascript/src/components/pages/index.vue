<template>
  <div>
    <router-link :to="{name: 'list'}">一覧ページ</router-link>
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
    <h1>新規試合表作成</h1>
    <div>
      会場: {{placeName}}
    </div>
    <div>
      日付: {{dateFormat(detailDate)}}
    </div>
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
        @selectImg="selectImg"
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
import memberModal from '../home/memberModal.vue';
import opponentModal from '../home/opponentModal.vue';
import masu from '../home/masu.vue';
import teams from '../home/teams.vue';
import Mixin from '../../mixin';
const teamMap = {
  1: 'my_kimete',
  2: 'aite_kimete'
};
export default {
  components: {
    memberModal,
    opponentModal,
    masu,
    teams,
  },
  mixins: [Mixin],
  name: "index",
  data: () => {
    return {
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
        { team_id: 1, opponent_id: 1, my_kimete: [], aite_kimete: [], position: 1},
        { team_id: 2, opponent_id: 2, my_kimete: [], aite_kimete: [], position: 2},
        { team_id: 3, opponent_id: 3, my_kimete: [], aite_kimete: [], position: 3},
        { team_id: 4, opponent_id: 4, my_kimete: [], aite_kimete: [], position: 4},
        { team_id: 5, opponent_id: 5, my_kimete: [], aite_kimete: [], position: 5},
      ],
      masuId: 0,
      schoolName: "",
      placeName: "",
      detailDate: "",
    }
  },
  computed: {
    getMatchId() {
      return this.$route.params.matchId;
    },
    customCells() {
      // const matchID = this.$route.params.matchId;
      const result = [];
      // const oddCell = this.cells.filter(item => item.id % 2 !== 0);
      // const evenCell = this.cells.filter(item => item.id % 2 === 0);
      this.regMembers.forEach((item, index) => {
        const cloneRegMember = Object.assign({}, item);
        const cloneOppMember = Object.assign({}, this.oppMembers[index]);
        delete cloneRegMember.name;
        delete cloneOppMember.name;
        cloneRegMember['my_kimete'] = this.cells[index].my_kimete.join(',');
        cloneRegMember['aite_kimete'] = this.cells[index].aite_kimete.join(',');
        cloneRegMember['match_id'] = Number(this.getMatchId);
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
      console.log(id);
      this.masuId = id;
      // this.isHanteiModalShow = !this.isHanteiModalShow;
    },
    toggleMemberShow() {
      this.isMemberModalShow = !this.isMemberModalShow;
    },
    toggleOpponentShow() {
      this.isOpponentModalShow = !this.isOpponentModalShow;
    },
    selectImg(val) {
      const index = val.index;
      const checkTeam = val.checkTeam;
      const cell = this.cells
        .filter(cell => cell.position === this.masuId)
        .map(map => {
          map[teamMap[checkTeam]].push(index);
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
  created() {
    fetch(`api/matches/${this.getMatchId}`)
    .then(res => res.json())
    .then(res =>  {
      this.schoolName = res.school_name;
      this.placeName = res.place_name;
      this.detailDate = res.create_date;
    })
    .catch(err => console.log(err));
  }
}
</script>