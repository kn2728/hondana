class ReadsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @books = current_user.books
    @book = Book.new
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
    @users = User.find(params[:id])
    @books.users.delete(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, user_ids:[])
  end
  
end
