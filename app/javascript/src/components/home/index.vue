<template>
  <div>
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
      <div class="match-table__list">
        <div 
          class="match-table__list--cell"
          v-for="member in regMembers"
          :key="member.id"
        >
          {{member.name}}
        </div>
      </div>
      <!-- 試合表 -->
      <div class="match-table__list">
        <div class="match-table__list--cell2"         v-on:click="toggleHanteiShow"
        >
        <div v-if="items.length">
          <div v-for="item in items" :key="item">
            <img :src="item" class="match-table__icon">
          </div>
        </div>
        </div>
      </div>
      <!-- 相手のチーム -->
      <div class="match-table__list">
        <div 
          class="match-table__list--cell"
          v-for="member in oppMembers"
          :key="member.id"
        >
          {{member.name}}
        </div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">○○高校</div>
        <div class="match-table__list--cell">{{schoolName}}</div>
      </div>
    </div>
  </div>
</template>
<script>
import men from '../../assets/images/men.svg'
import kote from '../../assets/images/kote.svg'
import dou from '../../assets/images/dou.svg'
import hanteiModal from './hanteiModal.vue';
import memberModal from './memberModal.vue';
import opponentModal from './opponentModal.vue';
const images = {
  0: men,
  1: kote,
  2: dou,
};
export default {
  components: {
    hanteiModal,
    memberModal,
    opponentModal,
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
      schoolName: "△△高校",
    }
  },
  computed: {
  },
  methods: {
    toggleHanteiShow() {
      this.isHanteiModalShow = !this.isHanteiModalShow;
    },
    toggleMemberShow() {
      this.isMemberModalShow = !this.isMemberModalShow;
    },
    toggleOpponentShow() {
      this.isOpponentModalShow = !this.isOpponentModalShow;
    },
    selectImg(index) {
      this.items.push(images[index]);
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