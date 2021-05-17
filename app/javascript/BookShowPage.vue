<template>
  <div class="container">
    <div class="raw d-flex">
      <img :src="book.book.image_url" style="height:150px;" class="rounded float-start">
      <div class="d-flex-col">
        <h3 class="m-2">『{{ book.book.title }}』</h3>
        <h4 class="m-2 p-2"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
              </svg>{{ book.book.author }}</h4>
        <!-- <router-link :to="{ name: 'BookEditPage' }">編集</router-link> -->
      </div>
    </div>
    <hr>
      <form @submit.prevent="createMemo">
      <div v-if="errors.length != 0">
        <ul v-for="e in errors" :key="e">
          <li><font color="red">{{ e }}</font></li>
        </ul>
      </div>
      <div>
        <label></label>
        <input v-model="memo.content" type="text" style="width:80%">
      <button type="submit">メモ</button>
      </div>
      </form>
      <hr>
    <div class="row">
      <div v-for="memo in book.memos" :key="memo.id" class="ml-2 mx-3 w-100">
        <div class="d-flex">
          <div>
        {{ memo.created_at|moment }}
          </div>
          <div class="mx-2 pl-3">
        {{ memo.content }}
          </div>
        </div>
        <div class="text-right">
          <button @click="deleteTarget = memo.id; showModal = true">Delete</button>
        </div>
        <hr>
      </div>
    </div>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteMemo(); showModal = false;">
      <div slot="body">よろしいですか?</div>
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
      errors: ''
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
    }
  }
}
</script>

<style scoped>
</style>