<template>
  <div>
    <modal 
      :isShow="isShow"
      @toggleShow="toggleShow"
      @selectImg="selectImg"
    />
    <h1>試合表</h1>
    <span>2020/8/6(水)</span>
    <button type="button" class="print" onclick="window.print();">印刷</button>
    <div v-for="team in teams" :key="team.id">
      {{team.name}}
    </div>
    <div class="match-table">
      <div class="match-table__list">
        <div class="match-table__list--cell">佐藤</div>
        <div class="match-table__list--cell2"         v-on:click="toggleShow"
        >
        <div v-if="items.length">
          <div v-for="item in items" :key="item">
            <img :src="item" class="match-table__icon">
          </div>
        </div>
        </div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">田中</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">鈴木</div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">武藤</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">鈴木</div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">武藤</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">鈴木</div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">武藤</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">鈴木</div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell2"></div>
        <div class="match-table__list--cell">武藤</div>
      </div>
      <div class="match-table__list">
        <div class="match-table__list--cell">○○高校</div>
        <div class="match-table__list--cell">△△高校</div>
      </div>
    </div>
    <input type="radio" id="先鋒" value="1" v-model="position">
    <label for="先鋒">先鋒</label>
    <input type="radio" id="次鋒" value="2" v-model="position">
    <label for="次鋒">次鋒</label>
    <input type="radio" id="中堅" value="3" v-model="position">
    <label for="中堅">中堅</label>
    <input type="radio" id="副将" value="4" v-model="position">
    <label for="副将">副将</label>
    <input type="radio" id="大将" value="5" v-model="position">
    <label for="大将">大将</label>
    <span>Position: {{ position }}</span> 
    <br>
    <input type="radio" id="メン" value="1" v-model="waza">
    <label for="メン">メン</label>
    <input type="radio" id="コテ" value="2" v-model="waza">
    <label for="コテ">コテ</label>
    <input type="radio" id="ドウ" value="3" v-model="waza">
    <label for="ドウ">ドウ</label>
    <span>取得: {{ waza }}</span> 
    <br>
    <input type="radio" id="とった" value="1" v-model="istotta">
    <label for="とった">とった</label>
    <input type="radio" id="取られた" value="2" v-model="istotta">
    <label for="取られた">取られた</label>
    <span>とった?: {{ istotta }}</span> 
    <button
      @click="onIppon"
    >反映</button>
  </div>
</template>
<script>
import men from '../../assets/images/men.svg'
import kote from '../../assets/images/kote.svg'
import dou from '../../assets/images/dou.svg'
import modal from './modal.vue';
const images = {
  0: men,
  1: kote,
  2: dou,
};
export default {
  components: {
    modal,
  },
  name: "index",
  data: () => {
    return {
      member: 5,
      isShow: false,
      items: [],
      teams: [],
      position: "",
      waza: "",
      istotta: "",
      content: ""
    }
  },
  computed: {
    test() {
      return this.$refs.hogehoge;
    }
  },
  methods: {
    toggleShow() {
      this.isShow = !this.isShow;
    },
    selectImg(index) {
      this.items.push(images[index]);
    },
    onIppon() {

    }
  },
  mounted() {
    fetch('api/teams')
    .then(res => {
      return res.json();
    })
    .then(res => {
      this.teams = res;
    })
  }
}
</script>