class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = current_user.books
    @book = Book.new   #投稿一覧画面で新規投稿を行うので、formのパラメータ用にPostオブジェクトを取得
  end

  def show
    @book = Book.find(params[:id])
    @memos = @book.memos  #投稿詳細に関連付けてあるコメントを全取得
    @memo = current_user.memos.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      respond_to do |format|
        format.html { redirect_to books_url, notice: "本が追加されました" }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    memo = @book.memos.find(params[:id])
    memo.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author).merge(user_id: current_user.id)
  end
end
