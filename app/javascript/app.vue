<template>
  <div>
    <router-view></router-view>
    <footer class="container-fluid mt-auto">
      <div class="row footer">
        <span class="text-muted mx-auto py-3">© Hondana 2021</span>
      </div>
    </footer>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'

import BookIndexPage from 'BookIndexPage.vue'
import BookShowPage from 'BookShowPage.vue'
import BookNewPage from 'BookNewPage.vue'
import BookEditPage from 'BookEditPage.vue'
import BookSearchPage from 'BookSearchPage.vue'
import SummaryNewPage from 'SummaryNewPage.vue'
import SummaryIndexPage from 'SummaryIndexPage.vue'
import SummaryEditPage from 'SummaryEditPage.vue'



const router = new VueRouter({
  routes: [
    { path: '/',
      component: BookIndexPage  },
    { path: '/books/:id(\\d+)',  // :id は数値のみに制限する
      name: 'BookShowPage',  // ルートに名前を付けている ref. https://router.vuejs.org/ja/guide/essentials/named-routes.html#%E5%90%8D%E5%89%8D%E4%BB%98%E3%81%8D%E3%83%AB%E3%83%BC%E3%83%88
      component: BookShowPage },
    { path: '/books/new',
      name: 'BookNewPage',
      component: BookNewPage },
    { path: '/books/:id(\\d+)/edit',
      name: 'BookEditPage',
      component: BookEditPage   },
    { path: '/books/search',
      name: 'BookSearchPage',
      component: BookSearchPage   },
    { path: '/books/:id(\\d+)/summaries/new',  // :id は数値のみに制限する
      name: 'SummaryNewPage',  // ルートに名前を付けている ref. https://router.vuejs.org/ja/guide/essentials/named-routes.html#%E5%90%8D%E5%89%8D%E4%BB%98%E3%81%8D%E3%83%AB%E3%83%BC%E3%83%88
      component: SummaryNewPage },
    { path: '/books/:id(\\d+)/summaries',  // :id は数値のみに制限する
      name: 'SummaryIndexPage',  // ルートに名前を付けている ref. https://router.vuejs.org/ja/guide/essentials/named-routes.html#%E5%90%8D%E5%89%8D%E4%BB%98%E3%81%8D%E3%83%AB%E3%83%BC%E3%83%88
      component: SummaryIndexPage },
    { path: '/books/:book_id(\\d+)/summaries/:id(\\d+)/edit',  // :id は数値のみに制限する
      name: 'SummaryEditPage',  // ルートに名前を付けている ref. https://router.vuejs.org/ja/guide/essentials/named-routes.html#%E5%90%8D%E5%89%8D%E4%BB%98%E3%81%8D%E3%83%AB%E3%83%BC%E3%83%88
      component: SummaryEditPage },
  ]
})

// ref. https://jp.vuejs.org/v2/guide/plugins.html#%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%AE%E4%BD%BF%E7%94%A8
Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
footer{
  opacity: 0.8;
}
</style>