<template>
  <dl>
    <dt>title</dt>
    <dd>{{ book.title }}</dd>
    <dt>author</dt>
    <dd>{{ book.author }}</dd>
    <dt>image</dt>
    <dd>{{ book.image_url }}</dd>
    <router-link :to="{ name: 'BookEditPage' }">編集</router-link>
  </dl>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      book: {}
    }
  },
  mounted () {
    axios
      .get(`/api/v1/books/${this.$route.params.id}.json`)
      .then(response => (this.book = response.data))
  }
}
</script>

<style scoped>
</style>