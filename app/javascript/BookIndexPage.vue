<template>
  <div id="app">
      <table class="container mb-2">
        <search></search>
        <div class="row">
          <div v-if="books.length===0" class="my-5 mx-auto p-5 text-center shadow">上の検索画面から本を追加してね
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
            </svg>
          </div>
          <div v-for="b in books" :key="b.id" class="col-6 col-md-3 text-center p-2">
            <div class="shadow h-100">
          <div class="text-center py-2"><router-link :to="{ name: 'BookShowPage', params: { id: b.id } }">
            <img :src="require('../assets/images/bookirust.png')" v-if="b.image_url===null" class="bigimage rounded mx-auto d-block">
            <img :src="b.image_url" class="bigimage rounded mx-auto d-block" v-else>
            </router-link></div>
            <h6 class="text-center">『{{ b.title }}』</h6>
            <div class="text-center text-muted">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
              </svg>{{ b.author }}</div>
            <div class="text-right mr-0 pr-0">
            <button type="button" class="btn btn-outline-dark btn-sm pt-2 text-muted" @click="deleteTarget = b.id; showModal = true" style="border:none;">
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                        </svg>
            </button>
            </div>
            </div>
          </div>
        </div>
      </table>
      <modal v-if="showModal" @cancel="showModal = false" @ok="deleteBook(); showModal = false;">
      <div slot="body">本棚から削除します。よろしいですか?</div>
      </modal>
      <!-- <router-link to="/books/new">本の追加</router-link> -->
    </div>
</template>

<script>
import axios from 'axios';
import Modal from 'Modal.vue';
import Search from 'BookSearchPage.vue'

export default {
  components: {
    Modal,
    Search
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

img {
  height: 130px;
  transition: 0.5s;
}

img:hover{
  transform:scale(1.1,1.1);
  transition: 0.5s;
}

button{
  cursor: pointer;
}

.shadow{
  box-shadow: 0px 0px 10px 2px rgba(0,0,0,0.3);   /* 影指定 */
  border-radius: 3px;                             /* 角丸指定 */
  transition: 0.3s;
}

.shadow:hover{
  box-shadow: 0px 0px 14px 5px rgba(0,0,0,0.3);   /* 影指定 */
  border-radius: 5px;                             /* 角丸指定 */
  transition: 0.3s;
}

</style>
