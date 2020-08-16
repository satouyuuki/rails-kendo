import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import HomeIndex from './components/home/index.vue';
import NewMatch from './components/pages/newMatch.vue';
import MatchList from './components/pages/matchList.vue';
import NotFound from './components/pages/404.vue';

const router = new VueRouter({
  routes: [
    { path: '/', component: HomeIndex, name: 'root_path' },
    { path: '/new', component: NewMatch, name: 'newMatch' },
    { path: '/new/:matchId', component: HomeIndex, name: 'newMatchList' },
    { path: '/list', component: MatchList, name: 'list' },
    { path: '*', component: NotFound },
  ]
});
export default router;
