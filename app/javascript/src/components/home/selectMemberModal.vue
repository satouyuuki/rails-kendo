<template>
  <BaseModal 
    ref="BaseModalRef"
    title="タイトルテスト"
  >
    test2modal
  </BaseModal>
</template>
<script>
import BaseModal from '../parts/BaseModal';
export default {
  name: "selectMemberModal",
  components: {
    BaseModal
  },
  data: () => {
    return {
    }
  },
  methods: {
    open() {
      this.$refs.BaseModalRef.open();
    }
  },
}
</script>