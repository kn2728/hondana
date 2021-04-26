class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user , except: :create

  def index
  end

  def show
    @book = Book.find(params[:id])
    @memos = Memo.where(book_id: @book.id, user_id: current_user.id)  #投稿詳細に関連付けてあるコメントを全取得
    @memo = current_user.memos.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    @read = Read.where(book_id: @book.id, user_id: current_user.id)
  end
  def new
    @book = Book.new
  end
  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    if @book.persisted?
      @book.users << current_user
      if @book.save
        respond_to do |format|
          format.html { redirect_to root_path, notice: "本が追加されました" }
          format.json { head :no_content }
        end
      end
    else 
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @item = Book.create(read(results.first))
      @item.users << current_user
      if @item.save
        respond_to do |format|
          format.html { redirect_to root_path, notice: "本が追加されました" }
          format.json { head :no_content }
        end
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

  def read(result)
    title = result['title']
    author = result['author']
    isbn = result['isbn']
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    {
      title: title,
      author: author,
      isbn: isbn,
      image_url: image_url
    }
  end
  def ensure_correct_user
    @read = Read.where(user_id: current_user.id, book_id: params[:id])
    if @read.blank?
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end
end
