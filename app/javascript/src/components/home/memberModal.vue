<template>
  <div class="mask" v-if="isMemberModalShow" v-on:click.self="onToggleShow">
    <div class="m-card">
      <button type="button" class="m-card__close-btn" v-on:click="onToggleShow">閉じる</button>
      <h2>メンバーを編成</h2>
      <button @click="addMember">決定</button>
      <draggable class="draggable-wrap" v-model="members" group="Regular" @start="drag=true" @end="drag=false">
        <div class="draggable" v-for="member in members" :key="member.id">
          {{member.name}}
        </div>
      </draggable>
      <draggable class="draggable-wrap" v-model="regMembers" group="Regular" @start="drag=true" @end="drag=false">
        <div class="draggable" v-for="member in regMembers" :key="member.id">
          {{member.name}}
        </div>
      </draggable>
    </div>
  </div>
</template>
<script>
import draggable from 'vuedraggable';
export default {
  name: "memberModal",
  components: {
    draggable,
  },
  props: [
    'isMemberModalShow',
  ],
  data: () => {
    return {
      options: {
        group: "Regular"
      },
      members: [],
      regMembers: [],
    }
  },
  methods: {
    onToggleShow() {
      this.$emit('toggleMemberShow');
    },
    addMember() {
      this.$emit('decisionMember', this.regMembers);
      this.onToggleShow();
    }
  },
  mounted() {
    fetch('api/teams')
      .then(res => {
        return res.json();
      })
      .then(res => {
        this.members = res;
      })
  }
}
</script>