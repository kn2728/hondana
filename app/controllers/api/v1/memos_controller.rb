class Api::V1::MemosController < ApiController
  before_action :set_memo, only: %w[create destroy]

  def create
    memo = current_user.memos.new(memo_params)
    if memo.save
      render json: memo, status: :created
    else
      render json: { errors: memo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_memo
    @book = Book.find(params[:book_id])
  end

  # Only allow a list of trusted parameters through.
  def memo_params
    params.permit(:content, :user_id, :book_id)
  end
end