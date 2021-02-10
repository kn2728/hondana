class ReadsController < ApplicationController
  def index
    @books = Book.all
  end

  def delete
    @book = Book.find(params[:id])
    @book.users.delete(current_user.id)
  end

  private

  
end
