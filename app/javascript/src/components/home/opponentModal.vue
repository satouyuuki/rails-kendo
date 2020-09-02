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
    'members'
  ],
  data: () => {
    return {
      options: {
        group: "Regular"
      },
      members: [],
    }
  },
  methods: {
    open() {
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