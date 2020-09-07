<template>
  <div class="container">
    <memberCreateModal
      ref="memberCreateModalRef"
      :school-id="schoolData.schoolId"
      @created="getOpponents"
    />
    <template v-if="viewType === 'new'">
      <button type="button" class="active-btn--large" @click="createLog">作成完了</button>
    </template>
    <template v-else-if="viewType === 'edit'">
      <router-link tag="button" :to="{name: 'detail'}" class="close-btn--large">戻る</router-link>
      <button type="button" class="active-btn--large" @click="createLog">編集完了</button>
    </template>
    <template v-else-if="viewType === 'detail'">
      <router-link tag="button" :to="{name: 'edit'}" class="active-btn--large">編集する</router-link>
    </template>
    <!-- タイトルを算出する -->
    <h1>{{getTitle}}</h1>
    <div>
      会場: {{placeName}}
    </div>
    <div>
      日付: {{dateFormat(detailDate)}}
    </div>
    <button type="button" class="close-btn" onclick="window.print();">印刷</button>
    <template v-if="viewType === 'new' || viewType === 'edit'">
      <button type="button" class="active-btn" @click="openMemberCreateModal()">相手チーム作成</button>
    </template>
    <div class="match-table">
      <div class="table-head">
        <div class="table-head__cell">自分の高校</div>
        <div class="table-head__cell">{{schoolData.schoolName}}</div>
      </div>
      <!-- 自分のチーム -->
      <teams :members="regMembers"/>
      <!-- 試合表 -->
      <masu 
        :viewType="viewType"
        :cells="cells"
        @toggleHanteiShow="toggleHanteiShow"
        @selectImg="selectImg"
        @deletePoint="deletePoint"
      />
      <!-- 相手のチーム -->
      <teams :members="oppMembers"/>
    </div>
    <div class="hantei-text" v-bind:class="{ 'win': setHaniteNum === 1, 'lose':setHaniteNum === 3 }">
      {{getWinText}}
    </div>
    <p>
      チームポシション(先鋒・次鋒・中堅・副将・大将)はドラッグアンドドロップで変更できます。<br>
      また、登録済み選手はマスの下にあります。(スクロール可能)
    </p>
  </div>
</template>
<script>
import memberCreateModal from '../home/memberCreateModal.vue';
import masu from '../home/masu.vue';
import teams from '../home/teams.vue';
import Mixin from '../../mixin';
import {teamMap, hanteiText, modalType} from '../../constant';
export default {
  components: {
    memberCreateModal,
    masu,
    teams,
  },
  mixins: [Mixin],
  name: "index",
  data: () => {
    return {
      regMembers: [],
      oppMembers: [],
      cells: [],
      masuId: 0,
      schoolData: {
        schoolId: 0,
        schoolName: ''
      },
      placeName: "",
      detailDate: "",
      viewType: "",
    }
  },
  watch: {
    '$route': (to, from) => {
      let self = this
      if(to.name === 'edit') {
        self.viewType = to.name;
      }
    }
  },
  computed: {
    setMemberPosition() {
      this.regMembers.map((map, index) => {
        map.position = index + 1;
      })
    },
    setOpponentPosition() {
      this.oppMembers.map((map, index) => {
        map.position = index + 1;
      })
    },
    /** ページタイトルを算出 */
    getTitle() {
      let title = '';
      switch(this.viewType) {
        case 'new':
          title = '新規作成';
          break;
        case 'detail':
          title = '詳細';
          break;
        case 'edit':
          title = '編集';
          break;
        default:
          title = 'タイトル';
      }
      return title;
    },
    // reduce使えそう
    setAllMyPoints() {
      const points = this.cells.map(cell => {
        return cell.my_kimete.length
      })
      const reducer = (accumulator, currentValue) => accumulator + currentValue;
      return points.reduce(reducer, 0)
    },
    setAllAitePoints() {
      const points = this.cells.map(cell => {
        return cell.aite_kimete.length
      })
      const reducer = (accumulator, currentValue) => accumulator + currentValue;
      return points.reduce(reducer, 0)
    },
    setMyWinNum() {
      let myWinNum = 0;
      const points = this.cells.map(cell => {
        if (cell.my_kimete.length > cell.aite_kimete.length) {
          myWinNum++;
        }
      })
      return myWinNum;
    },
    setAiteWinNum() {
      let aiteWinNum = 0;
      const points = this.cells.map(cell => {
        if (cell.aite_kimete.length > cell.my_kimete.length) {
          aiteWinNum++;
        }
      })
      return aiteWinNum;
    },
    setHaniteNum() {
      // 勝者数が多い時
      if(this.setAllMyPoints > this.setAllAitePoints) {
        return 1;
      } 
      else if (this.setAllMyPoints === this.setAllAitePoints) {
        // 勝者数も取得数も同じ時
        if(this.setMyWinNum > this.setAiteWinNum) {
          return 1;
        }
        else if(this.setMyWinNum === this.setAiteWinNum) {
          return 2;
        }
        return 3;
      }
      else {
        return 3;
      }
    },
    getWinText() {
      return `${this.setMyWinNum}(${this.setAllMyPoints}) - ${this.setAiteWinNum}(${this.setAllAitePoints}) = ${hanteiText[this.setHaniteNum]}`;
    },
    getMatchId() {
      return this.$route.params.matchId;
    },
    customCells() {
      const result = [];
      this.cells.forEach((map, index) => {
        const cloneMap = Object.assign({}, map);
        cloneMap.match_id = Number(this.getMatchId);
        cloneMap.aite_kimete = map.aite_kimete.toString();
        cloneMap.my_kimete = map.my_kimete.toString();
        cloneMap.team_id = this.regMembers[index].team_id;
        cloneMap.opponent_id = this.oppMembers[index].opponent_id;
        result.push(cloneMap)
      });
      return result;
    }
  },
  methods: {
    openMemberCreateModal() {
      this.$refs.memberCreateModalRef.open();
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
      .then(res => {
        alert('登録に成功しました。');
          this.$router.push({
            name: 'list'
          })
          .catch(err => {});
      })
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
          const oppNum = this.oppMembers.length;
          res.map((map, index) => {
            if(oppNum <= index) {
              this.oppMembers.push({
                opponent_id: map.id,
                name: map.name,
              })
            }
          })
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
            })
          })
        })
        .catch(err => console.log(err));
    },
    getLogs() {
      fetch(`/api/logs/${this.getMatchId}`)
      .then(res => res.json())
      .then(res => {
        this.cells.map((map, index) => {
          map.my_kimete = res[index].my_kimete.length > 0 ? res[index].my_kimete.split(',') : [];
          map.aite_kimete = res[index].aite_kimete.length > 0 ? res[index].aite_kimete.split(',') : []
        });
      })
    },
    initLogs() {
      for(let i = 0; i < 5; i++) {
        this.cells.push({
          my_kimete: [],
          aite_kimete: [],
          position: i + 1
        })
      }
    }
  },
  async created() {
    console.log('created');
    this.viewType = this.$route.name;
    await this.getMatches();
    this.initLogs();
    if(this.viewType !== 'new') {
      this.getLogs();
    }
    this.getOpponents();
    this.getTeams();
  }
}
</script>
<style scoped lang="scss">
.match-table {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  max-width: 700px;
}
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