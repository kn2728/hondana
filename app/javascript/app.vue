<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'

import BookIndexPage from 'BookIndexPage.vue'
import BookShowPage from 'BookShowPage.vue'
import BookNewPage from 'BookNewPage.vue'
import BookEditPage from 'BookEditPage.vue'

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
      component: BookEditPage   }
  ]
})

// ref. https://jp.vuejs.org/v2/guide/plugins.html#%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%AE%E4%BD%BF%E7%94%A8
Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>