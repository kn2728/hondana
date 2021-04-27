class Api::BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @memos = Memo.where(book_id: @book.id, user_id: current_user.id).order('created_at DESC')  # 投稿詳細に関連付けてあるコメントを全取得
    @memo = current_user.memos.new  # 投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    @read = Read.where(book_id: @book.id, user_id: current_user.id)
  end
end
