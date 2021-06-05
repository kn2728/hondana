<template>
    <div class="container">
      <!-- <div class="row d-flex">
        <img :src="book.book.image_url" style="height:150px;" class="rounded float-start">
        <div class="d-flex-col">
          <h3 class="m-2">『{{ book.book.title }}』</h3>
          <h4 class="m-2 p-2"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                </svg>{{ book.book.author }}</h4>
        </div>
      </div>
      <hr>
      <form @submit.prevent="createSummary">
        <h4>要約:</h4>
        <div v-if="errors.length != 0">
          <ul v-for="e in errors" :key="e">
            <li><font color="red">{{ e }}</font></li>
          </ul>
        </div>
        <div>
          <textarea v-model="summary.matome" class="w-100" style="height:150px;" placeholder="例) ・・・に感動した。"></textarea>
          <div class="text-right">
          <button type="submit" >投稿する</button>
          </div>
        </div>
      </form>
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
          <hr>
        </div>
      </div> -->
      <summary-form-pane :errors="errors" :book="book" @submit="createSummary"></summary-form-pane>
  </div>
</template>

<script>
  import axios from 'axios';
  import moment from 'moment';
  import Modal from 'Modal.vue';
  import SummaryFormPane from 'SummaryFormPane.vue';

export default {
  components: {
    Modal,
    SummaryFormPane
  },
  data: function () {
    return {
      book: {},
      // summary: {
      //   matome:'',
      //   book_id:this.$route.params.id
      // },
      errors:''
    }
  },
  mounted () {
    axios
      .get(`/api/v1/books/${this.$route.params.id}/summaries/new.json`)
      .then(response => (this.book = response.data))
  },
  filters: {
    moment: function(date) {
      return moment(date).format('YYYY/MM/DD HH:mm');
    }
  },
  methods:{
    createSummary: function() {
      this.book.summary.book_id = this.$route.params.id;
      axios
        .post(`/api/v1/books/${this.$route.params.id}/summaries`, this.book.summary)
        .then(response => {
          let e = response.data;
          this.$router.push({ name: 'BookShowPage', params: { id: this.$route.params.id } });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  }
}
</script>

<style scoped>
.container{
  margin-top: 72px;
}
</style>