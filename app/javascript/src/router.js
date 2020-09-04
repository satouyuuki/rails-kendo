import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import HomeIndex from './components/pages/index.vue';
import baseLayout from './components/layouts/baseLayout.vue';
import MatchList from './components/pages/matchList.vue';
// import MatchDetail from './components/pages/matchDetail.vue';
// import MatchEdit from './components/pages/matchEdit.vue';
import NotFound from './components/pages/404.vue';

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: baseLayout,
      children: [
        { path: '', component: MatchList, name: 'list' },
        { path: 'new/:matchId', component: HomeIndex, name: 'new', },
        { path: 'detail/:matchId', component: HomeIndex, name: 'detail' },
        { path: 'edit/:matchId', component: HomeIndex, name: 'edit' },
        { path: '*', component: NotFound },
      ]
    },
  ]
});
export default router;
