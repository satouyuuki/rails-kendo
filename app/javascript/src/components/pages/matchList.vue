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
import newMatchModal from '../home/newMatchModal';
import Mixin from '../../mixin';

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
    setMatchList() {
      fetch('/api/matches')
      .then(res => res.json())
      .then(res => {
        console.log(res);
        this.matchLists = res;
      })
    },
    deleteList(id) {
      if(!confirm('本当に削除しますか？')) return;
      fetch(`/api/matches/${id}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
      })
      .then(res => res.json())
      .then(res => {
        this.setMatchList();
      })
      .catch(err => console.log(err));
    }
  },
  created() {
    this.setMatchList();
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