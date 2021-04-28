<template>
  <form @submit.prevent="$emit('submit')">
    <div v-if="errors.length != 0"> <!--エラーメッセージ表示 -->
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <div>
      <label>Title</label>
      <input v-model="book.title" type="text">
    </div>
    <div>
      <label>Author</label>
      <input v-model="book.author" type="text">
    </div>
    <div>
      <label>isbn</label>
      <input v-model="book.isbn" type="number">
    </div>
    <div>
      <label>image</label>
      <input v-model="book.image_url" type="text">
    </div>
    
    <button type="submit">Commit</button>
  </form>
</template>

<script>
export default {
  props: {
    book: {},
    errors: ''
  }
}
</script>

<style>
</style>
