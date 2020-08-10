import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
Vue.use(VueRouter);

import HomeIndex from './components/home/index.vue';

const router = new VueRouter({
  routes: [
    { path: '/', component: HomeIndex, name: 'root_path' },
  ]
});
export default router;
