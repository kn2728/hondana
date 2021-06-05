<template>
  <div class="container">
    <div class="raw">
      <input type="text" v-model='title' placeholder="本のタイトルを打ち込んでください" class="pl-1 col-9">
      <button type="button" class="btn btn-outline-info col-2" style="cursor: pointer;" @click='getSearch(title)'>検索</button>
    </div>
            <ul v-for='result in results' :key='result.id'>
                <div class="d-flex my-2">
                    <div class="mr-2">
                    <li><img :src="result.Item.largeImageUrl"></li>
                    </div>
                    <div>
                    <li class="mb-3">{{ result.Item.title }}</li>
                    <li class="mb-3">{{ result.Item.author }}</li>
                    <li>出版社：{{ result.Item.publisherName }}</li>
                    </div>
                </div>
                    <form @submit.prevent="createBook(result.Item.isbn)">
                    <div v-if="errors.length != 0">
                        <ul v-for="e in errors" :key="e">
                        <li><font color="red">{{ e }}</font></li>
                        </ul>
                    </div>
                    <div class="text-right">
                        <button type="submit" class="btn btn-outline-primary">追加</button>
                    </div>
                    </form>
            </ul>
            <hr>
  </div>
</template>

<script>
import axios from 'axios'

export default {
    name: 'search',
    data() {
        return {
            title: '',
            results: [],
            apiKey: 1027697410333068131n,
            book:{
                isbn:''
            },
            errors: ''

        }
    },
    methods: {
        getSearch(title) {
           axios.get(`https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?applicationId=${this.apiKey}&title=${title}`)
           .then(response => {
               this.results = response.data.Items
           })
           .catch(error => {
                console.error(error);
                if (error.response.data && error.response.data.errors) {
                this.errors = error.response.data.errors;}
            });
        },
        createBook(book) {
            // console.log(this.book)
            this.book.isbn = book;
            axios.post(`/api/v1/books`,this.book)
            .then(response => {
                this.$router.go();
            })
            .catch(error => {
                console.error(error);
                if (error.response.data && error.response.data.errors) {
                this.errors = error.response.data.errors;}
            });
        },
        updateValue: function(e) {
          this.$emit("input", e.target.value);
        }
    }
}
</script>

<style scoped>
ul{
    list-style-type: none;
}

img {
  height: 130px;
}

input {
    width: 85%;
    margin-right: 4px;
    height: 40px;
}

.container{
    margin-top: 75px;
}

</style>