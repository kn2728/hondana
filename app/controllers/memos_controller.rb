class MemosController < ApplicationController
  # before_action :set_memo, only: %w[ show edit update destroy ]
    before_action :set_memo, only: %w[ create destroy ]
  # GET /memos
  # GET /memos.json
  # def index
  #   @memos = Memo.all
  # end

  # GET /memos/1
  # GET /memos/1.json
  #  def show
  #  end

  # GET /memos/new
  # def new
  #   @memo = Memo.new
  # end

  # GET /memos/1/edit
  # def edit
  # end

  # POST /memos
  # POST /memos.json
  def create
    @memo = current_user.memos.new(memo_params)
    if @memo.save
      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: "メモしました" }
        format.json { render :show, status: :created, location: @book }
      end
    else
      @memos = Memo.where(book_id: @book.id, user_id: current_user.id)  #投稿詳細に関連付けてあるコメントを全取得
      @read = Read.where(book_id: @book.id, user_id: current_user.id)
      render template: "books/show"
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  # def update
  #   respond_to do |format|
  #     if @memo.update(memo_params)
  #       format.html { redirect_to @memo, notice: "Memo was successfully updated." }
  #       format.json { render :show, status: :ok, location: @memo }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @memo.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo = @book.memos.find(params[:id])
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to book_path(@book), notice: "メモを削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @book = Book.find(params[:book_id])
    end

    # Only allow a list of trusted parameters through.
    def memo_params
      params.require(:memo).permit(:content, :user_id, :book_id)
    end
end
