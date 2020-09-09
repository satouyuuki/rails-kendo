<template>
  <BaseModal 
    ref="BaseModalRef"
    title="新しい試合会場を登録する"
    add-btn-text="追加"
    @clicked="onAddPlace"
    @closed="closed"
  >
    <div class="m-card__list">
      <label>会場名</label>
      <input v-model="newPlace" placeholder="会場名を入力してください">
    </div>
  </BaseModal>
</template>
<script>
import BaseModal from '../base/BaseModal';
import {place} from '../../service';
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
    close() {
      this.$refs.BaseModalRef.onClose();
    },
    closed() {
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
      place.createPlaceApi(data)
      .then(res => {
        alert(`${res.name}会場を追加しました。`);
        this.setData(res);
        this.close();
      })
    }
  },
}
</script>