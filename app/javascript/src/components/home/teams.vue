<template>
  <div class="match-table__list">
    <div 
      class="match-table__list--cell"
      v-for="(member, index) in members"
      :key="member.id"
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
  ]
}
</script>