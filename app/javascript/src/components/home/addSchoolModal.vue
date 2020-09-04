<template>
  <BaseModal 
    ref="BaseModalRef"
    title="新しい学校を登録する"
  >
    <div class="m-card__list">
      <label>学校名</label>
      <input v-model="newSchool">
      <button @click="backPrev">閉じる</button>
      <button @click="onAddSchool">追加</button>
    </div>
  </BaseModal>
</template>
<script>
import BaseModal from '../parts/BaseModal';
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
    backPrev() {
      this.$refs.BaseModalRef.close();
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
      this.matchData = data;
      fetch('api/schools', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify(data)
      })
      .then(res => res.json())
      .then(res => {
        console.log(res);
        alert(`${res.name}会場を追加しました。`);
        this.setData(res);
        this.backPrev();
      })
      .catch(err => console.log(err));
    }
  },
}
</script>