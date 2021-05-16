<template>
  <div class="container">
    <div class="raw d-flex">
      <img :src="book.book.image_url" style="height:100px;" class="rounded float-start">
      <div class="d-flex-col">
        <div class="m-2">『{{ book.book.title }}』</div>
        <div class="m-2 p-2"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
              </svg>{{ book.book.author }}</div>
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
        <label>memo</label>
        <input v-model="memo.content" type="text">
      </div>
      <button type="submit">Commit</button>
      </form>
      <hr>
    <div class="row">
      <div v-for="memo in book.memos" :key="memo.id" class="mx-auto">
        {{ memo.created_at|moment }}
        {{ memo.content }}
        <hr>
      </div>
    </div>

  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment';

export default {
  data: function () {
    return {
      book: [],
      memo:{
        content: '',
      },
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
    }
  }
}
</script>

<style scoped>
</style>