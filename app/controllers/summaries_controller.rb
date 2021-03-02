class SummariesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_read
  before_action :set_summary, only: %w[ index new create edit update]

  def index
    @summaries = Summary.all
    @summary = current_user.summaries.find_by(user_id: current_user.id)
  end

  def new
    @summary = Summary.new
    @memos = Memo.where(book_id: @book.id, user_id: current_user.id)
  end

  def create
    @summary = current_user.summaries.new(summary_params)
    if @summary.save
      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: "投稿しました" }
        format.json { render :show, status: :created, location: @book }
      end
    else
      @memos = @book.memos  #投稿詳細に関連付けてあるコメントを全取得
      render "new"
    end
  end

  def edit
    @summary = current_user.summaries.find_by(user_id: current_user.id)
    @summaries = Summary.find_by(id: params[:id])
  end

  def update
    @summary = current_user.summaries.new(summary_params)
    @summaries = Summary.find_by(id: params[:id])
    if @summaries.update(summary_params)
      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: "編集しました" }
        format.json { render :show, status: :created, location: @book }
      end
    else
      render "edit"
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

    def find_read
      @read = Read.find_by(user_id: current_user.id)
      if @read.nil? || @read.user_id != current_user.id
        flash[:notice] = "権限がありません"
        redirect_to root_path
      end
    end
end
