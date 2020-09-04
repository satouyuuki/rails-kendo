<template>
  <div>
    <memberModal 
      ref="memberModalRef"
      @decisionMember="decisionMember"
      :regMembers="regMembers"
    />
    <memberModal 
      ref="opponentModalRef"
      @decisionMember="decisionMember"
      :regMembers="oppMembers"
    />
    <h1>新規試合表作成</h1>
    <div>
      会場: {{placeName}}
    </div>
    <div>
      日付: {{dateFormat(detailDate)}}
    </div>
    <button type="button" class="print" onclick="window.print();">印刷</button>
    <button type="button" class="member" @click="openMemberChangeModal(1)">メンバー編成</button>
    <button type="button" class="member" @click="openMemberChangeModal(2)">相手チーム</button>
    <button type="button" class="member" @click="createLog">作成</button>

    <div class="match-table">
      <div class="table-head">
        <div class="table-head__cell">自分の高校</div>
        <div class="table-head__cell">{{schoolData.schoolName}}</div>
      </div>
      <!-- 自分のチーム -->
      <teams :members="regMembers"/>
      <!-- 試合表 -->
      <masu 
        :cells="cells"
        @toggleHanteiShow="toggleHanteiShow"
        @selectImg="selectImg"
        @deletePoint="deletePoint"
      />
      <!-- 相手のチーム -->
      <teams :members="oppMembers"/>
    </div>
    <div class="hantei-text" v-bind:class="{ 'win': hanteiTextNum === 1, 'lose':hanteiTextNum === 2 }">
      {{getWinRate}}
    </div>
  </div>
</template>
<script>
import memberModal from '../home/memberModal.vue';
import selectMemberModal from '../home/selectMemberModal.vue';
import masu from '../home/masu.vue';
import teams from '../home/teams.vue';
import Mixin from '../../mixin';
import {teamMap, hanteiText, modalType} from '../../constant';
export default {
  components: {
    memberModal,
    selectMemberModal,
    masu,
    teams,
  },
  mixins: [Mixin],
  name: "index",
  data: () => {
    return {
      regMembers: [],
      oppMembers: [],
      cells: [
        { team_id: 1, opponent_id: 1, my_kimete: [], aite_kimete: [], position: 1},
        { team_id: 2, opponent_id: 2, my_kimete: [], aite_kimete: [], position: 2},
        { team_id: 3, opponent_id: 3, my_kimete: [], aite_kimete: [], position: 3},
        { team_id: 4, opponent_id: 4, my_kimete: [], aite_kimete: [], position: 4},
        { team_id: 5, opponent_id: 5, my_kimete: [], aite_kimete: [], position: 5},
      ],
      masuId: 0,
      schoolData: {
        schoolId: 0,
        schoolName: ''
      },
      placeName: "",
      detailDate: "",
      hanteiTextNum: 3,
      modalType: ""
    }
  },
  computed: {
    getWinRate() {
      let allMyPoints = 0;
      let allAitePoints = 0;
      let myWinNum = 0;
      let aiteWinNum = 0;
      this.cells.forEach(({my_kimete, aite_kimete}) => {
        if(my_kimete.length > 0) {
          allMyPoints += my_kimete.length;
        }
        if(aite_kimete.length > 0) {
          allAitePoints += aite_kimete.length;
        }
        if (my_kimete.length !== aite_kimete.length) {
          my_kimete.length > aite_kimete.length ? myWinNum++ : aiteWinNum++;
        }
      });
      if(myWinNum > aiteWinNum) {
        this.hanteiTextNum = 1;
      } 
      else if (myWinNum === aiteWinNum) {
        if(allMyPoints === allAitePoints) this.hanteiTextNum = 3;
        allMyPoints > allAitePoints ? this.hanteiTextNum = 1 : (allMyPoints === allAitePoints ? this.hanteiTextNum = 3 : this.hanteiTextNum = 2);
      }
      return `${myWinNum}(${allMyPoints}) - ${aiteWinNum}(${allAitePoints}) = ${hanteiText[this.hanteiTextNum]}`;
    },
    getMatchId() {
      return this.$route.params.matchId;
    },
    customCells() {
      const result = [];
      this.cells.forEach(map => {
        const cloneMap = Object.assign({}, map);
        cloneMap.match_id = Number(this.getMatchId);
        cloneMap.aite_kimete = map.aite_kimete.join(',');
        cloneMap.my_kimete = map.my_kimete.join(',');
        result.push(cloneMap)
      });
      return result;
    }
  },
  methods: {
    openMemberChangeModal(id) {
      this.modalType = modalType[id];
      if(this.modalType === 'member') {
        this.$refs.memberModalRef.open();
      }
      else if(this.modalType === 'opponent') {
        this.$refs.opponentModalRef.open();
      }
    },
    testModal() {
      this.$refs.selectMemberModal.open();
    },
    createLog() {
      fetch('/api/logs', {
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
    },
    selectImg(val) {
      const index = val.index;
      const checkTeam = val.checkTeam;
      const cell = this.cells
        .filter(cell => cell.position === this.masuId)
        .map(map => {
          console.log(map['my_kimete']);
          console.log(typeof map[teamMap[checkTeam]]);
          // console.log(index);
          map[teamMap[checkTeam]].push(index);
          return map;
        });
    },
    deletePoint(val) {
      const item = val.item;
      const checkTeam = val.checkTeam;
      const cell = this.cells
        .filter(cell => cell.position === this.masuId)
        .map(map => {
          const targetTeam = map[teamMap[checkTeam]];
          const targetIndex = targetTeam.indexOf(item);
          if(targetIndex >= 0) {
            targetTeam.splice(targetIndex, 1);
            map[teamMap[checkTeam]] = targetTeam;
          }
        });
    },
    decisionMember(members) {
      if(!members || members.length < 5) return;
      if(this.modalType === 'member') {
        this.regMembers.map((map, index) => {
          map.team_id = members[index].team_id;
          map.name = members[index].name;
        })
      }
      if(this.modalType === 'opponent') {
        this.oppMembers.map((map, index) => {
          map.opponent_id = members[index].opponent_id;
          map.name = members[index].name;
        })
      }
    },
    async getMatches() {
      return fetch(`/api/matches/${this.getMatchId}`)
        .then(res => res.json())
        .then(res =>  {
          this.schoolData = {
            schoolId: res.school_id,
            schoolName: res.school_name
          };
          this.placeName = res.place_name;
          this.detailDate = res.create_date;
        })
        .catch(err => console.log(err));
    },
    getOpponents() {
      fetch(`/api/opponents/${this.schoolData.schoolId}`)
        .then(res => res.json())
        .then(res =>  {
          res.map((map, index) => {
            this.oppMembers.push({
              opponent_id: map.id,
              name: map.name,
              position: index + 1
            })
          })
          console.log(res);
        })
        .catch(err => console.log(err));
    },
    getTeams() {
      fetch('/api/teams')
        .then(res => res.json())
        .then(res =>  {
          res.map((map, index) => {
            this.regMembers.push({
              team_id: map.id,
              name: map.name,
              position: index + 1
            })
          })
        })
        .catch(err => console.log(err));
    }
  },
  async created() {
    await this.getMatches();
    this.getOpponents();
    this.getTeams();
  }
}
</script>
<style scoped lang="scss">
.table-head{
  width: 100%;
  display: flex;
  justify-content: space-evenly;
  &__cell {
  }
}
.hantei-text {
  font-size: 2rem;
  text-align: center;
  &.win {
    color: red;
  }
  &.lose {
    color: blue;
  }
}
</style>