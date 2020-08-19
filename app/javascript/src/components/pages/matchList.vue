<template>
  <div>
    <router-link to="/new">新しい試合を作成</router-link>
    <h1>試合リスト</h1>
    <ul>
      <li v-for="list in matchLists" :key="list.id">
        <router-link :to="{name: 'detail', params: {matchId: `${list.id}`}}">{{list.created_at}}</router-link>
      </li>
    </ul>
  </div>
</template>
<script>
import moment from 'moment';
moment.locale('ja');
const dataFormat = 'LLLL';

export default {
  name: "matchList",
  data() {
    return {
      matchLists: [],
    }
  },
  created() {
    fetch('api/matches')
    .then(res => res.json())
    .then(res => {
      res.map(map => {
        map.created_at = moment(map.created_at).format(dataFormat);
      })
      this.matchLists = res;
    })
  }
}
</script>