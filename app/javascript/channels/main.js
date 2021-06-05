'use strict';
onload= function(){
  
  const open = document.getElementById('open');
  const close = document.getElementById('close');
  const modal = document.getElementById('modal');
  const mask = document.getElementById('mask');

  open.addEventListener('click',() => {
    modal.classList.remove('hidden');
    mask.classList.remove('hidden');
  });

  close.addEventListener('click',() => {
    modal.classList.add('hidden');
    mask.classList.add('hidden');
  });

  mask.addEventListener('click',() => {
    close.click();
  });

  $(function(){
    $(window).on('load scroll', function() {
       var winScroll = $(window).scrollTop();
       var winHeight = $(window).height();
       var scrollPos = winScroll + (winHeight * 0.8);
 
       $(".show").each(function() {
          if($(this).offset().top < scrollPos) {
             $(this).css({opacity: 1, transform: 'translate(0, 0)'});
          }
       });
    });
 });

 // スクロールイベント
window.addEventListener( "scroll", function() {

  var headerElement = document.getElementById( "header" ) ; // `#header`セレクタを取得
  var rect = headerElement.getBoundingClientRect() ; // 
  var y = rect.top + window.pageYOffset ; // Y方向 (縦)にスクロール量を取得（pageYOffset：windowオブジェクト。現在表示位置のY座標を取得）
  if (y > 0) { // 変数yの値が0よりも
    headerElement.classList.remove('hidden'); // 大きければhiddenセレクタを削除する
  } else {
    headerElement.classList.add('hidden'); // そうでなければhiddenセレクタを追加する
  }
});
}