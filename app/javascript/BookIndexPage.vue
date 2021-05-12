<template>
  <div id="app">
      <table class="container">
        <tbody class="row">
          <div v-for="b in books" :key="b.id" class="col-6 col-md-3 border border-success my-2 w-80">
          <div class="text-center py-2"><router-link :to="{ name: 'BookShowPage', params: { id: b.id } }">
            <img :src="require('../assets/images/bookirust.png')" style="height:100px;" v-if="b.image_url===null" class="rounded mx-auto d-block">
            <img :src="b.image_url" style="height:100px;" class="rounded mx-auto d-block" v-else>
            </router-link></div>
            <h4 class="text-center">『{{ b.title }}』</h4>
            <div class="text-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
              </svg>{{ b.author }}</div>
            <div>
            <button @click="deleteTarget = b.id; showModal = true">Delete</button>
            </div>
          </div>
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
      errors: '',
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
