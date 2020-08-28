<template>
  <div class="mask" v-if="isShow" v-on:click.self="close">
    <div class="m-card">
      <button type="button" class="m-card__close-btn" v-on:click="close">閉じる</button>
      <h2>新しく試合表を作成する</h2>
      <div class="m-card__list">
        <select v-model="selectedPlace">
          <option v-for="place in places" :key="place.id" v-bind:value="place.id">
            {{place.name}}
          </option>
        </select>
        <select v-model="selectedSchool">
          <option v-for="school in schools" :key="school.id" v-bind:value="school.id">
            {{school.name}}
          </option>
        </select>
        <button @click="createMatch">決定</button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data: () => {
    return {
      isShow: false,
      selectedPlace: "",
      selectedSchool: "",
      places: [],
      schools: [],
    }
  },
  methods: {
    open() {
      this.isShow = true;
    },
    close() {
      this.isShow = false;
    },
    createMatch() {
      if(!this.selectedPlace && !this.selectedSchool) return;
      const data = {
        place_id: this.selectedPlace,
        school_id: this.selectedSchool
      }
      this.matchData = data;
      fetch('api/matches', {
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
        this.$router.push({
          name: 'newMatchList',
          params: {
            matchId: res.id,
          },
        })
      })
      .catch(err => console.log(err));
    }
  },
  created() {
    fetch('api/places')
      .then(res => {
        return res.json();
      })
      .then(res => {
        this.places = res;
      })
      .catch(err => {});
    fetch('api/schools')
      .then(res => {
        return res.json();
      })
      .then(res => {
        this.schools = res;
      })
      .catch(err => {});
  }
}
</script>