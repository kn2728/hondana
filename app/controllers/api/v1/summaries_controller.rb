class Api::V1::SummariesController < ApiController
  before_action :set_summary, only: %w[index new create edit update]

  def index
    @summaries = Summary.where(book_id: @book.id).as_json(include: { user: { only: :nickname } })
    @summary = current_user.summaries.find_by(book_id: @book.id)
    render json: { summaries: @summaries, summary: @summary, book: @book }
  end

  def new
    @memos = Memo.where(book_id: @book.id, user_id: current_user.id).order('created_at DESC')  # 投稿詳細に関連付けてあるコメントを全取得
    @summary = Summary.new
    render json: { book: @book, memos: @memos, summary: @summary }
  end

  def create
    @summary = current_user.summaries.new(summary_params)
    if @summary.save
      Read.where(book_id: @book.id, user_id: current_user.id).update(complete: true)
      render json: @summary, status: :created
    else
      render json: { errors: @summary.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def edit
    @memos = Memo.where(book_id: @book.id, user_id: current_user.id).order('created_at DESC')
    @summary = Summary.find_by(id: params[:id])
    render json: { book: @book, memos: @memos, summary: @summary }
  end

  def update
    @summary = Summary.find_by(id: params[:id])
    if @summary.update(summary_params)
      head :no_content
    else
      render json: { errors: @summary.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_summary
    @book = Book.find(params[:book_id])
  end

  def summary_params
    params.require(:summary).permit(:matome, :user_id, :book_id)
  end
end
