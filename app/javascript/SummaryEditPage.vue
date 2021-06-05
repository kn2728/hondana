<template>
    <div>
      <summary-form-pane :errors="errors" :book="book" @submit="updateSummary"></summary-form-pane>
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
      errors:''
    }
  },
  mounted () {
    axios
      .get(`/api/v1/books/${this.$route.params.book_id}/summaries/${this.$route.params.id}/edit`)
      .then(response => (this.book = response.data))
  },
  filters: {
    moment: function(date) {
      return moment(date).format('YYYY/MM/DD HH:mm');
    }
  },
  methods:{
    updateSummary: function() {
      axios
        .patch(`/api/v1/books/${this.$route.params.book_id}/summaries/${this.$route.params.id}`, this.book.summary)
        .then(response => {
          let e = response.data;
          this.$router.push({ name: 'SummaryIndexPage', params: { id: this.$route.params.book_id } });
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