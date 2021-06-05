<template>
  <div class="container">
    <div class="raw d-flex p-2">
      <img :src="book.book.image_url" style="height:150px;" class="rounded float-start shadow">
      <div class="d-flex-col">
        <div class="m-2">『{{ book.book.title }}』</div>
        <div class="m-2 p-2"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-circle pt-1" viewBox="0 0 16 16">
              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
              </svg>{{ book.book.author }}</div>
        <div v-for="r in book.read" :key=r.id class="">
          <!-- <button @click="bookComplete" v-if="r.complete===false" class="mx-3 btn btn-outline-success">読書完了</button> -->
          <router-link :to="{name: 'SummaryNewPage', params:{id: book.book.id}}" v-if="r.complete===false" class="mx-3 btn btn-outline-success">読書完了</router-link>
          <div v-else-if="r.complete===true" class="mx-3">
          <router-link :to="{name: 'SummaryIndexPage', params:{id: book.book.id}}" class="mx-3 btn btn-outline-success">
            みんなの要約を見る
          </router-link>
          </div>
        </div>
      </div>
    </div>
      <form @submit.prevent="createMemo" class="mt-0">
      <div>
        <label></label>
        <div class="memo">
      <div v-if="errors.length != 0">
        <ul v-for="e in errors" :key="e">
          <li><font color="red">{{ e }}</font></li>
        </ul>
      </div>
        <input v-model="memo.content" type="text" placeholder="自分用のメモとしてご利用ください。" autofocus>
        </div>
        <div class="text-right">
        <button type="submit" class="btn btn-outline-secondary btn-sm px-3 mt-2">メモ</button>
        </div>
      </div>
      </form>
      <hr>
    <div class="row">
      <div v-for="memo in book.memos" :key="memo.id" class="m-2 mx-3 w-100 shadow">
        <div class="d-flex">
          <div class="text-muted">
        {{ memo.created_at|moment }}
          </div>
          <div class="mx-2 pl-3">
        {{ memo.content }}
          </div>
        </div>
        <div class="text-right">
          <button @click="deleteTarget = memo.id; showModal = true" style="border:none;" class="btn btn-outline-dark">削除</button>
        </div>
      </div>
    </div>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteMemo(); showModal = false;">
      <div slot="body">このメモを削除します。</div>
      </modal>

  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment';
import Modal from 'Modal.vue'

export default {
  components: {
    Modal
  },
  data: function () {
    return {
      book: [],
      memo:{
        content: '',
      },
      showModal: false,
      deleteTarget: -1,
      errors: '',
    }
  },
  filters: {
    moment: function(date) {
      console.log(date);
      return moment(date).format('YYYY/MM/DD HH:mm');
    }
  },
  mounted () {
    axios
      .get(`/api/v1/books/${this.$route.params.id}.json`)
      .then(response => (this.book = response.data))
  },
  methods: {
    createMemo: function() {
      axios
        .post(`/api/v1/books/${this.$route.params.id}/memos`, this.memo)
        .then(response => {
          let e = response.data;
          this.$router.go();
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    deleteMemo: function() {
      if (this.deleteTarget <= 0) {
        console.warn('deleteTarget should be grater than zero.');
        return;
      }
      axios
      .delete(`/api/v1/books/${this.$route.params.id}/memos/${this.deleteTarget}`)
      .then(response => {
          this.deleteTarget = -1;
          this.$router.go();
        })
      .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    bookComplete: function() {
      axios
      // .patch(`/api/v1/books/${this.$route.params.id}`, this.book)
      .then(response => {
        this.$router.push({ name: 'SummaryNewPage', params: { id: this.$route.params.id } });
      })
      .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>

<style scoped>
.container{
  margin-top: 72px;
}

.summary{
  text-decoration: none;
  transition: 0.3s;
}

.summary:hover{
  transition: 0.3s;
  color: coral;
  font-weight: bold;
}

.shadow{
  box-shadow: 0px 0px 10px 2px rgba(0,0,0,0.3);   /* 影指定 */
  border-radius: 3px;                             /* 角丸指定 */
  transition: 0.3s;
}

.memo input[type='text']{
    width: 100%; /*親要素いっぱい広げる*/
    padding: 10px 15px; /*ボックスを大きくする*/
    font-size: 16px;
    border-radius: 3px; /*ボックス角の丸み*/
    border: 2px solid #ddd; /*枠線*/
    box-sizing: border-box; /*横幅の解釈をpadding, borderまでとする*/
}
</style>