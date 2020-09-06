<template>
  <BaseModal 
    ref="BaseModalRef"
    title="新しい対戦校を登録する"
    add-btn-text="追加"
    @clicked="onAddSchool"
    @closed="closed"
  >
    <div class="m-card__list">
      <label>学校名</label>
      <input v-model="newSchool" placeholder="対戦校を入力してください">
    </div>
  </BaseModal>
</template>
<script>
import BaseModal from '../parts/BaseModal';
import {school} from '../../service';
export default {
  data: () => {
    return {
      newSchool: "",
    }
  },
  components: {
    BaseModal
  },
  methods: {
    open() {
      this.$refs.BaseModalRef.open();
    },
    close() {
      this.$refs.BaseModalRef.onClose();
    },
    closed() {
      this.$emit('open');
    },
    setData(data) {
      this.$emit('setData', data)
    },
    onAddSchool() {
      if(!this.newSchool) return;
      const data = {
        name: this.newSchool,
      }
      school.createSchoolApi(data)
        .then(res => {
          alert(`${res.name}を追加しました。`);
          this.setData(res);
          this.close();
        })
    }
  },
}
</script>