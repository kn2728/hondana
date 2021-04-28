<template>
  <div id="app">
      <table>
        <tbody>
          <tr>
            <th>id</th>
            <th>title</th>
            <th>author</th>
            <th>image</th>
          </tr>
          <tr v-for="b in books" :key="b.id">
            <td><router-link :to="{ name: 'BookShowPage', params: { id: b.id } }">{{ b.id }}</router-link></td>
            <td>{{ b.title }}</td>
            <td>{{ b.author }}</td>
            <td>{{ b.image_url }}</td>
            <td>
            <button @click="deleteTarget = b.id; showModal = true">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
      <modal v-if="showModal" @cancel="showModal = false" @ok="deleteBook(); showModal = false;">
      <div slot="body">Are you sure?</div>
      </modal>
      <router-link to="/books/new">本の追加</router-link>
    </div>
</template>

<script>
import axios from 'axios';

import Modal from 'Modal.vue'

export default {
  components: {
    Modal
  },
  data: function () {
    return {
      books:[],
      showModal: false,
      deleteTarget: -1,
      errors: ''
    }
  },
  mounted(){
    this.updateBooks();
  },
  methods: {
    deleteBook: function() {
      if (this.deleteTarget <= 0) {
        console.warn('deleteTarget should be grater than zero.');
        return;
      }

      axios
      .delete(`/api/v1/books/${this.deleteTarget}`)
      .then(response => {
          this.deleteTarget = -1;
          this.updateBooks();
        })
      .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    updateBooks:function(){
      axios
      .get('/api/v1/books.json')
      .then(response => (
        this.books = response.data
      ))
    }
  }
}


</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
