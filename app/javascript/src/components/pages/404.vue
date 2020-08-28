<template>
  <div>
    このページは存在しません
    <button @click="openModal">モーダルを起動</button>
    <testModal ref="testRef"/>
  </div>
</template>
<script>
import testModal from '../parts/testModal';
export default {
  components: {
    testModal
  },
  openModal() {
    this.$refs.testRef.open();
  }
}
</script>