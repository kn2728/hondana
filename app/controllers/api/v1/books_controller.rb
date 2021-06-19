class Api::V1::BooksController < ApiController
  before_action :set_book, only: [:show, :update, :destroy]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    books = current_user.books.order('created_at DESC')
    render json: books
  end

  def show
    @memos = Memo.where(book_id: @book.id, user_id: current_user.id).order('created_at DESC') # 投稿詳細に関連付けてあるコメントを全取得
    @memo = current_user.memos.new # 投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    @read = Read.where(book_id: @book.id, user_id: current_user.id)
    render json: { book: @book, memos: @memos, read: @read }
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params[:isbn])
    if @book.persisted?
      @book.users << current_user
      if @book.save
        render json: @book, status: :created
      else
        render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
      end
    else
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @item = Book.create(read(results.first))
      @item.users << current_user
      if @item.save
        render json: @item, status: :created
      else
        render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
      end
    end
    # book = Book.new(book_params)
    # if book.save
    #   render json: book, status: :created
    # else
    #   render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    # end
  end

  # def update
  # @book = Book.find(params[:id])
  # Read.where(book_id: @book.id, user_id: current_user.id).update(complete: true)
  # head :no_content
  # if @book.update_attributes(book_params)
  #   head :no_content
  # else
  #   render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
  # end
  # end

  def destroy
    @book = Book.find(params[:id])
    @book.users.delete(current_user)
    head :no_content
    # @book.destroy!
  end

  def search
    gon.application_id = ENV['APPLICATION_ID']
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :image_url)
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

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end
end
