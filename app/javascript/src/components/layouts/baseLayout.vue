<template>
  <div>
    <Header/>
    <router-view :key="$route.name + ($route.params.page || '')"/>
    <Footer/>
  </div>
</template>
<script>
import Header from './Header';
import Footer from './Footer';
export default {
  name: 'baseLayout',
  components: {
    Header,
    Footer
  }
}
</script>