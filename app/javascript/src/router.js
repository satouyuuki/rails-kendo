import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import HomeIndex from './components/pages/index.vue';
import baseLayout from './components/layouts/baseLayout.vue';
import MatchList from './components/pages/matchList.vue';
import MatchDetail from './components/pages/matchDetail.vue';
import MatchEdit from './components/pages/matchEdit.vue';
import NotFound from './components/pages/404.vue';

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: baseLayout,
      children: [
        {
          path: 'new/:matchId',
          component: HomeIndex,
          name: 'newMatchList',
        },
        { path: 'list', component: MatchList, name: 'list' },
        { path: 'detail/:matchId', component: MatchDetail, name: 'detail' },
        { path: 'edit/:matchId', component: MatchEdit, name: 'edit' },
        { path: '*', component: NotFound },
      ]
    },
  ]
});
export default router;
