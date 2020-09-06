<template>
  <BaseModal 
    ref="BaseModalRef"
    title="メンバーを作成"
    add-btn-text="作成"
    @clicked="createMember"
  >
  <div v-for="(member, index) in members" :key="index">
    <input type="text" v-model="member.name" placeholder="選手名を入力してください"/>
  </div>
  </BaseModal>
</template>
<script>
import BaseModal from '../parts/BaseModal';
import {opponent} from '../../service';
export default {
  data: () => {
    return {
      members: []
    }
  },
  props: {
    schoolId: Number,
  },
  components: {
    BaseModal
  },
  computed: {
    getExistMember() {
      const filterMember = this.members.filter(item => item.name !== '');
      return filterMember;
    }
  },
  methods: {
    initMember() {
      for(let i = 0; i < 5; i++) {
        this.members.push({
          name: '',
          school_id: this.schoolId
        })
      }
    },
    open() {
      this.$refs.BaseModalRef.open();
      if(this.members.length !== 0) return;
      this.initMember();
    },
    close() {
      this.$refs.BaseModalRef.onClose();
    },
    createMember() {
      if(this.getExistMember.length === 0) return;
      const data = this.getExistMember;
      opponent.createOpponentApi(data)
      .then(res => {
        console.log(res.id);
        this.$emit('created')
        this.close();
      })
    }
  },
}
</script>