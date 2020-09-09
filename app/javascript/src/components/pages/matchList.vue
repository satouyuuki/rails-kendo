<template>
  <div class="container">
    <div @click="createNewMatch" class="active-btn--large">試合表作成</div>
    <h1>試合リスト</h1>
    <ul class="menu-list">
      <li class="menu-list__item" v-for="list in matchLists" :key="list.id">
        <router-link class="menu-list__link" :to="{name: 'detail', params: {matchId: `${list.id}`}}">
          作成日: {{dateFormat(list.created_at)}}<br>
          対戦高校: {{list.school_name}}<br>
          試合会場: {{list.place_name}}
        </router-link>
        <button class="menu-list__button" @click="deleteList(list.id)">×</button>
      </li>
    </ul>
    <newMatchModal ref="newMatchModal" />
  </div>
</template>
<script>
import newMatchModal from '../parts/newMatchModal';
import Mixin from '../../mixin';
import {match} from '../../service';
export default {
  name: "matchList",
  mixins: [Mixin],
  components: {
    newMatchModal
  },
  data() {
    return {
      matchLists: [],
    }
  },
  methods: {
    createNewMatch() {
      this.$refs.newMatchModal.open();
    },
    getMatchList() {
      match.getAllMatchApi()
      .then(res => {
        this.matchLists = res;
      })
    },
    deleteList(id) {
      if(!confirm('本当に削除しますか？')) return;
      match.deleteMatchApi(id)
      .then(res => {
        this.getMatchList();
      })
    }
  },
  created() {
    this.getMatchList();
  }
}
</script>
<style lang="scss" scoped>
@import "../../scss/variable.scss";
.menu-list {
    list-style: none;
    margin: 0;
    padding: 0;
  &__item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid $light-grey;
    padding: 5px 0;
  }
  &__link {
    color: $black;
    background: $white;
    transition: .4s;
    flex-grow: 1;
    text-decoration: none;
    &:hover {
      color: $white;
      background: $light-grey;
    }
  }
  &__button {
    width: 30px;
    height: 30px;
    background: $white;
    border: 1px solid red;
    color: red;
    transition: .4s;
    &:hover {
      color: $white;
      background: rgba(red, .4);
    }

  }
}
</style>