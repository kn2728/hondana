<template>
  <book-form-pane :errors="errors" :book="book" @submit="createBook"></book-form-pane>
</template>

<script>
import axios from 'axios';

import BookFormPane from 'BookFormPane.vue';

export default {
  components: {
    BookFormPane
  },
  data() {
    return {
      book: {
        title: '',
        author: '',
        isbn: '',
        image_url: '',
      },
      errors: ''
    }
  },
  methods: {
    createBook: function() {
      axios
        .post('/api/v1/books', this.book)
        .then(response => {
          let b = response.data;
          this.$router.push({ name: 'BookShowPage', params: { id: b.id } });
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