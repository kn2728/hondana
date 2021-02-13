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
    @book = Book.new(book_params)
    @book.users << current_user
    if @book.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "本が追加されました" }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.users.delete(current_user)
    respond_to do |format|
      format.html { redirect_to root_path, notice: "本を削除しました" }
      format.json { head :no_content }
    end
  end

  def update
    @book = Book.find(params[:id])
    Read.where(book_id: @book.id, user_id: current_user.id).update(complete: true)
    respond_to do |format|
      format.html { redirect_to root_path, notice: "読書完了しました" }
      format.json { head :no_content }
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, user_ids:[])
  end
end
