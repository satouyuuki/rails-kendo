<template>
  <div>
    <router-link to="{name='list'}">一覧ページ</router-link>
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
import hanteiModal from './hanteiModal.vue';
import memberModal from './memberModal.vue';
import opponentModal from './opponentModal.vue';
import masu from './masu.vue';
import teams from './teams.vue';
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
        {id: 1, name: ""},
        {id: 2, name: ""},
        {id: 3, name: ""},
        {id: 4, name: ""},
        {id: 5, name: ""},
      ],
      oppMembers: [
        {id: 1, name: ""},
        {id: 2, name: ""},
        {id: 3, name: ""},
        {id: 4, name: ""},
        {id: 5, name: ""},
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
      // this.cells
      //   .filter(cell => cell.id % 2 === 0)
      //   .map((map, index) => {
      //     console.log('oppid = '+this.oppMembers[index].id);
      //     console.log('mapid = '+map.id);
      //     map.id = this.oppMembers[index].id;
      //   });
    }
  },
  methods: {
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
      this.regMembers = members;
    },
    decisionOpponent(members) {
      if(members[0]) this.oppMembers = members[0];
      if(members[1]) this.schoolName = members[1];
    },
  },
  mounted() {
  }
}
</script>