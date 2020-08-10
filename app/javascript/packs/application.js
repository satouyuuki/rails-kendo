// console.log('Hello World from Webpacker')
import Vue from 'vue/dist/vue.esm';
import router from '../src/router.js';

const app = new Vue({
  router,
}).$mount('#app');
