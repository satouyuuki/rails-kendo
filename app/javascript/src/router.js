import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import HomeIndex from './components/home/index.vue';
import MatchList from './components/pages/matchList.vue';
import NotFound from './components/pages/404.vue';

const router = new VueRouter({
  routes: [
    { path: '/', component: HomeIndex, name: 'root_path' },
    { path: '/new', component: HomeIndex },
    { path: '/list', component: MatchList },
    { path: '*', component: NotFound },
  ]
});
export default router;
