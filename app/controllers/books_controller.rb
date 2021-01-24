class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  private

  def book_params
    params.require(:book).permit(:content, :image).merge(user_id: current_user.id)
  end
end
