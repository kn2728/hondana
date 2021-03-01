class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user

  def index
  end

  def show
    @book = Book.find(params[:id])
    @memos = Memo.where(book_id: @book.id, user_id: current_user.id)  #投稿詳細に関連付けてあるコメントを全取得
    @memo = current_user.memos.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    @read = Read.where(book_id: @book.id, user_id: current_user.id)
  end

  def create
    @book = Book.find_or_create_by(isbn: book_params[:isbn])
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
      format.html { redirect_to new_book_summary_path(@book), notice: "読書完了しました" }
      format.json { head :no_content }
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, user_ids:[])
  end

  def ensure_correct_user
    @read = Read.find(params[:id])
    if @read.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end
end
