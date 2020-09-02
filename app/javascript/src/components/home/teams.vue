<template>
  <div class="member-list">
    <div 
      class="member-list__cell"
      v-for="(member, index) in selectedMembers"
      :key="index"
    >
      <template v-if="index === 0">先鋒: {{member.name}}</template> 
      <template v-if="index === 1">次鋒: {{member.name}}</template> 
      <template v-if="index === 2">中堅: {{member.name}}</template> 
      <template v-if="index === 3">副将: {{member.name}}</template> 
      <template v-if="index === 4">大将: {{member.name}}</template> 
    </div>
  </div>
</template>
<script>
export default {
  name: "teams",
  props: [
    "members",
  ],
  computed: {
    selectedMembers() {
      const membersClone = this.members;
      const memNum = membersClone.length;
      if(memNum > 5) {
        return membersClone.filter(n => n.position <= 5);
      } 
      return membersClone;
    }
  }
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
  %table-cell {
    display: inline-block;
    width: 100%;
    height: 100%;
    padding: 15px;
    text-align: center;
    border: 1px solid $grey;
  }
  &__cell {
    @extend %table-cell;
  }
}
</style>