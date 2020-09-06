<template>
  <draggable class="member-list" :list="members">
    <div 
      class="member-list__cell"
      v-for="(member, index) in members"
      :key="index"
    >
      <template v-if="index === 0">先: {{member.name}}</template> 
      <template v-else-if="index === 1">次: {{member.name}}</template> 
      <template v-else-if="index === 2">中: {{member.name}}</template> 
      <template v-else-if="index === 3">副: {{member.name}}</template> 
      <template v-else-if="index === 4">大: {{member.name}}</template> 
      <template v-else>補: {{member.name}}</template> 
    </div>
  </draggable>
</template>
<script>
import draggable from 'vuedraggable';
export default {
  name: "teams",
  components: {
    draggable,
  },
  props: [
    "members",
  ],
}
</script>
<style lang="scss" scoped>
@import "../../scss/variable.scss";
.member-list {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  background-color: $white;
  max-width: 130px;
  overflow-y: auto;
  height: 350px;
  %table-cell {
    display: inline-block;
    width: 100%;
    min-height: 70px;
    padding: 15px;
    text-align: center;
    border: 1px solid $grey;
  }
  &__cell {
    @extend %table-cell;
  }
}
</style>