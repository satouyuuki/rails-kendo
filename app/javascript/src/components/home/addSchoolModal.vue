<template>
  <div class="mask" v-if="isShow" v-on:click.self="close">
    <div class="m-card">
      <button type="button" class="m-card__close-btn" v-on:click="close">閉じる</button>
      <h2>新しく試合表を作成する</h2>
      <div class="m-card__list">
        <label>学校名</label>
        <input v-model="newSchool">
        <button @click="backPrev">閉じる</button>
        <button @click="onAddSchool">追加</button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data: () => {
    return {
      isShow: false,
      newSchool: "",
    }
  },
  methods: {
    open() {
      this.isShow = true;
    },
    close() {
      this.isShow = false;
    },
    backPrev() {
      this.close();
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