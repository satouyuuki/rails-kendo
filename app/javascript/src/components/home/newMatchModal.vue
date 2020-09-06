<template>
  <div>
    <BaseModal 
      ref="BaseModalRef"
      title="試合表を作成する"
      add-btn-text="決定"
      @clicked="createMatch"
    >
      <div>
        <select v-model="selectedPlace">
          <option value="" disabled>選択してください</option>
          <option v-for="place in places" :key="place.id" v-bind:value="place.id">
            {{place.name}}
          </option>
        </select>
        <button class="active-btn" @click="onNewPlace">新規</button>
      </div>
      <div>
        <select v-model="selectedSchool">
          <option value="" disabled>選択してください</option>
          <option v-for="school in schools" :key="school.id" v-bind:value="school.id">
            {{school.name}}
          </option>
        </select>
        <button class="active-btn" @click="onNewSchool">新規</button>
      </div>
    </BaseModal>
    <addPlaceModal 
      ref="addPlaceRef" 
      @open="open" @setData="setPlaceData"/>
    <addSchoolModal 
      ref="addSchoolRef" 
      @open="open" @setData="setSchoolData" />
  </div>
</template>
<script>
import BaseModal from '../parts/BaseModal';
import addPlaceModal from '../home/addPlaceModal.vue';
import addSchoolModal from '../home/addSchoolModal.vue';
import {match, place, school} from '../../service';
export default {
  components: {
    BaseModal,
    addPlaceModal,
    addSchoolModal,
  },
  data: () => {
    return {
      selectedPlace: "",
      selectedSchool: "",
      places: [],
      schools: [],
    }
  },
  methods: {
    open() {
      this.$refs.BaseModalRef.open();
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
      this.$refs.BaseModalRef.close();
      this.$refs.addSchoolRef.open();
    },
    onNewPlace() {
      this.$refs.BaseModalRef.close();
      this.$refs.addPlaceRef.open();
    },
    setPlace() {
      place.getPlaceApi()
        .then(res => this.places = res);
    },
    setSchool() {
      school.getSchoolApi()
        .then(res => this.schools = res);
    },
    createMatch() {
      if(!this.selectedPlace && !this.selectedSchool) return;
      const data = {
        place_id: this.selectedPlace,
        school_id: this.selectedSchool
      }
      match.createMatchApi(data)
        .then(res => {
          this.$router.push({
            name: 'new',
            params: {
              matchId: res.id,
            },
          })
        })
    }
  },
  created() {
    this.setPlace();
    this.setSchool();
  }
}
</script>