class SummariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_summary, only: %w[ index new create ]

  def index
    @summaries = Summary.all
  end

  def new
    @summary = Summary.new
    @memos = @book.memos
  end

  def create
    @summary = current_user.summaries.new(summary_params)
    if @summary.save
      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: "投稿しました" }
        format.json { render :show, status: :created, location: @book }
      end
    else
      @summaries = @book.summaries  #投稿詳細に関連付けてあるコメントを全取得
      render template: "books/show"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_summary
      @book = Book.find(params[:book_id])
    end

    # Only allow a list of trusted parameters through.
    def summary_params
      params.require(:summary).permit(:matome, :user_id, :book_id)
    end
end
