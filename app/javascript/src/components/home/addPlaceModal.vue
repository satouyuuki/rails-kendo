<template>
  <BaseModal 
    ref="BaseModalRef"
    title="レギュラー編成"
  >
    <div class="m-card__list">
      <label>会場名</label>
      <input v-model="newPlace">
      <button @click="backPrev">閉じる</button>
      <button @click="onAddPlace">追加</button>
    </div>
  </BaseModal>
</template>
<script>
import BaseModal from '../parts/BaseModal';
export default {
  data: () => {
    return {
      newPlace: "",
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
    onAddPlace() {
      if(!this.newPlace) return;
      const data = {
        name: this.newPlace,
      }
      this.matchData = data;
      fetch('api/places', {
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