<template>
  <BaseModal 
    ref="BaseModalRef"
    title="レギュラー編成"
  >
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
  </BaseModal>
</template>
<script>
import BaseModal from '../parts/BaseModal';
import draggable from 'vuedraggable';
const modalType = {
  1: 'member',
  2: 'opponent',
}
export default {
  name: "memberModal",
  components: {
    draggable,
    BaseModal
  },
  props: [
    'modalType',
    'schoolId',
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
    open() {
      this.setMembers();
      this.$refs.BaseModalRef.open();
    },
    addMember() {
      const data = {
        modalType: this.modalType,
        members: this.regMembers
      }
      this.$emit('decisionMember', this.regMembers);
      this.$refs.BaseModalRef.close();
    },
    async setMembers() {
      await this.$nextTick();
      if(this.modalType == 1) {
        fetch('/api/teams')
          .then(res => {
            return res.json();
          })
          .then(res => {
            this.members = res;
          })
      }
      if(this.modalType == 2) {
        fetch(`/api/opponents/${this.schoolId}`)
          .then(res => {
            return res.json();
          })
          .then(res => {
            this.members = res;
          })
      }
    }
  },
}
</script>
<style scoped lang="scss">
@import '../../scss/variable';
.draggable {
  display: inline-block;
  margin: 10px;
  padding: 10px;
  border: 1px solid $grey;
  border-radius: 10px;
  background-color: $white;
  &:hover {
    cursor: grab;
  }
  &:active {
    cursor: grabbing;
  }
}
.draggable-wrap {
  min-width: 100px;
  min-height: 100px;
  border: 1px solid $grey;
}
</style>