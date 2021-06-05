<template>
  <div class="container">
      <div class="row d-flex p-2">
        <img :src="book.book.image_url" style="height:150px;" class="rounded float-start shadow">
        <div class="d-flex-col">
          <h3 class="m-2">『{{ book.book.title }}』</h3>
          <h4 class="m-2 p-2"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                </svg>{{ book.book.author }}</h4>
        </div>
      </div>
      <hr>
      <div class="shadow p-2">
        <h4>
          あなたの投稿：
        </h4>
        <div class="d-flex">
          <div class="text-muted">
            {{book.summary.created_at | moment}}
          </div>
          <div class="ml-2">
            {{book.summary.matome}}
          </div>
        </div>
          <div class="text-right">
          <router-link :to="{ name: 'SummaryEditPage', params: { id: book.summary.id ,book_id:book.book.id} }" class="btn btn-outline-success" style="border:none;">
              編集
          </router-link>
          </div>
      </div>
      <hr>
      <div class="">
        <h4>みんなの投稿：</h4>
        <div v-for="summary in book.summaries" :key="summary" class="mb-3 shadow p-2">
          <div class="d-flex">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-fill text-muted" viewBox="0 0 16 16">
            <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
            </svg>
            <div class="pb-2 text-primary">
              {{summary.user.nickname}}
            </div>
          </div>
          <div class="d-flex">
          <div class="text-muted">
              {{summary.created_at | moment}}
          </div>
          <div class="ml-2">
            {{summary.matome}}
          </div>
          </div>
          
        </div>
        </div>
  </div>
</template>

<script>
  import axios from 'axios';
  import moment from 'moment';
  import Modal from 'Modal.vue';

export default {
  components: {
    Modal,
  },
  data: function () {
    return {
      book: [],
      errors:''
    }
  },
  mounted () {
    axios
      .get(`/api/v1/books/${this.$route.params.id}/summaries.json`)
      .then(response => (this.book = response.data))
  },
  filters: {
    moment: function(date) {
      return moment(date).format('YYYY/MM/DD HH:mm');
    }
  },
}
</script>

<style scoped>
.container{
  margin-top: 85px;
}

.shadow{
  box-shadow: 0px 0px 10px 2px rgba(0,0,0,0.3);   /* 影指定 */
  border-radius: 3px;                             /* 角丸指定 */
  transition: 0.3s;
}
</style>