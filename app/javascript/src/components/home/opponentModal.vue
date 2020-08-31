<template>
  <div class="mask" v-if="isOpponentModalShow" v-on:click.self="onToggleShow">
    <div class="m-card">
      <button type="button" class="m-card__close-btn" v-on:click="onToggleShow">閉じる</button>
      <!-- 高校が選択されていない画面 -->
      <div v-if="!isSelectedSchool">
        <h2>高校を選択</h2>
        <ul>
          <li v-for="school in schools" :key="school.id" @click="selectSchool(school)">
            {{school.name}}
          </li>
        </ul>
      </div>
      <div v-else>
        <h2>メンバーを編成</h2>
        <button @click="addMember">決定</button>
        <draggable class="draggable-wrap" v-model="members" group="Regular" @start="drag=true" @end="drag=false">
          <div class="draggable" v-for="member in members" :key="member.id">
            {{member.name}}
          </div>
        </draggable>
        <draggable class="draggable-wrap" v-model="oppMembers" group="Regular" @start="drag=true" @end="drag=false">
          <div class="draggable" v-for="member in oppMembers" :key="member.id">
            {{member.name}}
          </div>
        </draggable>
      </div>
    </div>
  </div>
</template>
<script>
import draggable from 'vuedraggable';
export default {
  name: "opponentModal",
  components: {
    draggable,
  },
  props: [
    'isOpponentModalShow',
  ],
  data: () => {
    return {
      options: {
        group: "Regular"
      },
      members: [],
      oppMembers: [],
      schools: [],
      isSelectedSchoolFlg: false,
      schoolName: "",
    }
  },
  computed: {
    isSelectedSchool() {
      return this.isSelectedSchoolFlg;
    }

  },
  methods: {
    onToggleShow() {
      this.$emit('toggleOpponentShow');
    },
    addMember() {
      this.$emit('decisionOpponent', [this.oppMembers, this.schoolName]);
      this.onToggleShow();
    },
    selectSchool(school) {
      this.isSelectedSchoolFlg = true;
      this.schoolName = school.name;
      fetch(`api/opponents/${school.id}`)
        .then(res => {
          return res.json();
        })
        .then(res => {
          this.members = res;
          // this.isSelectedSchool = true;
        })
        .catch(err => {});
    }
  },
  created() {
    fetch('/api/schools')
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