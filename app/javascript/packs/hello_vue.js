import Vue from 'vue'
import App from './app.vue'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('hello'))
  const app = new Vue(App).$mount('hello')

  console.log(app)
})