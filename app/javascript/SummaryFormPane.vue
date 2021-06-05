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

      <form @submit.prevent="$emit('submit')">
        <h4>要約:</h4>
        <div v-if="errors.length != 0">
          <ul v-for="e in errors" :key="e">
            <li><font color="red">{{ e }}</font></li>
          </ul>
        </div>
        <div>
          <textarea v-model="book.summary.matome" class="w-100" style="height:150px;" placeholder="例) ・・・に感動した。" autofocus></textarea>
          <div class="text-right">
          <button type="submit" class="btn btn-outline-success">投稿する</button>
          </div>
        </div>
      </form>
      <hr>
      <div class="row">
        <div v-for="memo in book.memos" :key="memo.id" class="my-2 mx-3 p-3 w-100 shadow">
          <div class="d-flex">
            <div>
              {{ memo.created_at|moment }}
            </div>
            <div class="mx-2 pl-3">
              {{ memo.content }}
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
  props:{
    book: {},
    errors:''
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
  margin-top: 80px;
}

.shadow{
  box-shadow: 0px 0px 10px 2px rgba(0,0,0,0.3);   /* 影指定 */
  border-radius: 3px;                             /* 角丸指定 */
  transition: 0.3s;
}

textarea {
  width: 100%; /* 幅 */
  margin: 1em 0; /* 周囲の余白 */
  padding: 0.5em; /* 枠線内の余白 */
  font-size: 1em; /* フォントサイズ */
  border: solid 2px #e1e3e8; /* 枠線のスタイル */
  border-radius: 4px; /* 角丸に */
  resize: none; /* リサイズ不可に */
}
/* フォーカス時のスタイル */
textarea:focus {
  border-color: #56a9ff;
  outline: 0;
}
</style>