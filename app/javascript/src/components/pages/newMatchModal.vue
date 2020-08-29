<template>
  <div>
    <div class="mask" v-if="isShow" v-on:click.self="close">
      <div class="m-card">
        <button type="button" class="m-card__close-btn" v-on:click="close">閉じる</button>
        <h2>新しく試合表を作成する</h2>
        <div class="m-card__list">
          <div>
            <select v-model="selectedPlace">
              <option value="" disabled>選択してください</option>
              <option v-for="place in places" :key="place.id" v-bind:value="place.id">
                {{place.name}}
              </option>
            </select>
            <button @click="onNewPlace">新規</button>
          </div>
          <div>
            <select v-model="selectedSchool">
              <option value="" disabled>選択してください</option>
              <option v-for="school in schools" :key="school.id" v-bind:value="school.id">
                {{school.name}}
              </option>
            </select>
            <button @click="onNewSchool">新規</button>
          </div>
          <button @click="createMatch">決定</button>
        </div>
      </div>
    </div>
    <addPlaceModal ref="addPlaceRef" @open="open" @setData="setPlaceData"/>
    <addSchoolModal ref="addSchoolRef" @open="open" @setData="setSchoolData" />
  </div>
</template>
<script>
import addPlaceModal from '../home/addPlaceModal.vue';
import addSchoolModal from '../home/addSchoolModal.vue';
export default {
  components: {
    addPlaceModal,
    addSchoolModal,
  },
  data: () => {
    return {
      isShow: false,
      selectedPlace: "",
      selectedSchool: "",
      places: [],
      schools: [],
    }
  },
  computed: {
  },
  methods: {
    open() {
      this.isShow = true;
    },
    close() {
      this.isShow = false;
    },
    setPlaceData(data) {
      const newPlace = {
        id: data.id,
        name: data.name
      }
      this.places.push(newPlace);
      this.selectedPlace = data.id;
    },
    setSchoolData(data) {
      const newSchool = {
        id: data.id,
        name: data.name
      }
      this.schools.push(data);
      this.selectedSchool = data.id;
    },
    onNewSchool() {
      this.close();
      this.$refs.addSchoolRef.open();
    },
    onNewPlace() {
      this.close();
      this.$refs.addPlaceRef.open();
    },
    setPlace() {
      fetch('api/places')
        .then(res => {
          return res.json();
        })
        .then(res => {
          this.places = res;
        })
        .catch(err => {});
    },
    setSchool() {
      fetch('api/schools')
        .then(res => {
          return res.json();
        })
        .then(res => {
          this.schools = res;
        })
        .catch(err => {});
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
    this.setPlace();
    this.setSchool();
  }
}
</script>