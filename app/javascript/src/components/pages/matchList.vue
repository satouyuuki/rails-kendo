<template>
  <div>
    <div @click="createNewMatch" class="match-btn">試合表作成</div>
    <h1>試合リスト</h1>
    <ul>
      <li v-for="list in matchLists" :key="list.id">
        <router-link :to="{name: 'detail', params: {matchId: `${list.id}`}}">{{list.created_at}}</router-link>
        <button @click="deleteList(list.id)">×</button>
      </li>
    </ul>
    <newMatchModal ref="newMatchModal" />
  </div>
</template>
<script>
import newMatchModal from '../home/newMatchModal';
import Mixin from '../../mixin';
const dataFormat = 'LLLL';

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
      fetch('api/matches')
      .then(res => res.json())
      .then(res => {
        res.map(map => {
          map.created_at = this.dateFormat(map.created_at);
        })
        this.matchLists = res;
      })
    },
    deleteList(id) {
      console.log(id);
      fetch(`api/matches/${id}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
      })
      .then(res => res.json())
      .then(res => {
        console.log(res);
        alert('削除に成功しました。');
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