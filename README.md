# Hondana

## 概要
『Hondana』は本のメモと要約投稿サービスです。
[![Image from Gyazo](https://i.gyazo.com/23a3c8b23472f11a789829e35dd7fdf1.png)](https://gyazo.com/23a3c8b23472f11a789829e35dd7fdf1)

## 制作背景
毎日新聞社の世論調査で約9割の人が読書は大切と回答しているのに、文化庁の調査で1ヶ月に1冊も読まないと回答したのが47.3%。
<br>大切だとわかっているのに読まない。もしくは読む時間がないことに対して、
<br>**エンタメとしての読書を向上できないかと考え、制作しました。**
<br>読書が終わり要約を投稿するまで他者の要約が見えないようにしました。(要約のブラックボックス化
)
<br>
* 読書が楽しみになる
* 読書が終わった後に追加体験ができる
* ネタバレを気にせず投稿できる
<br>上記を理由にエンタメとしての価値が上がるではないかと考えました。

## URL
https://hondana2021.com
<br>

## 使用技術
* フロントエンド
 * HTML/CSS
 * Javascript
 * Vue.js 2.6.14
* バックエンド
 * Ruby 2.6.5
 * Ruby on Rails 6.1.3 (APIモード)
 * Rubocop（コード解析ツール)
 * Rspec（テスト)
* インフラ
 * Docker / Docker-compose
 * AWS (EC2 / RDS(MySQL) / S3 / VPC / IAM / Route53 / ACM / ALB / Cloudfront)
 * MySQL 8.0 / Unicorn / Nginx

## AWS構成図
![AWS Design (updated) (1)](https://user-images.githubusercontent.com/69581420/122664135-6c00ce80-d1da-11eb-823d-cb06fe7f0d74.png)

## ER図
![ER1 (1)](https://user-images.githubusercontent.com/69581420/122664155-88047000-d1da-11eb-8585-5d03298d56a7.png)

## 機能一覧
* ユーザー機能(devise)
 * 新規登録
  * ニックネーム
  * メールアドレス
  * パスワード
 * ログイン
 * ログアウト
 * ゲストログイン
* 本登録機能
 * タイトル検索(楽天Books API)
* メモ投稿機能
 * メモ投稿
 * メモ削除
* 要約投稿機能
 * 要約投稿
 * 編集
* 他ユーザー要約一覧(要約投稿後)

## 見ていただきたいポイント
* 他のアプリケーションにない機能の導入
 * 他ユーザーの要約ブラックボックス化
* ユーザー機能以外のところをSPA化
 * ユーザビリティを意識し、Vue.jsを導入
* 直感的に使用できるUI\UX
 * 広い幅の年齢層が使用することで、要約内容の充実化
* 楽天Books API導入
 * 本の表紙や情報を外部から取り入れる
* インフラにAWS,開発にDockerを導入
 * 多くの企業様で利用されている環境を体験

