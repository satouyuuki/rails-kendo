<template>
  <div>
    <h1>新しく試合表を作成する</h1>
    <button @click="createMatch">作成</button>
    <ul>
      <li v-for="place in places" :key="place.id">
        <label><input type="radio" v-model="checkPlace" v-bind:value="place.id">{{ place.name }}</label>
      </li>
    </ul>
    <ul>
      <li v-for="school in schools" :key="school.id">
        <label><input type="radio" v-model="checkSchool" v-bind:value="school.id">{{ school.name }}</label>
      </li>
    </ul>
  </div>
</template>
<script>
export default {
  data: () => {
    return {
      checkPlace: 1,
      checkSchool: 1,
      places: [],
      schools: [],
    }
  },
  methods: {
    createMatch() {
      if(!this.checkPlace && !this.checkSchool) return;
      const data = {
        place_id: this.checkPlace,
        school_id: this.checkSchool
      }
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
          params: {matchId: res.id}
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