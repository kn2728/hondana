class SearchesController < ApplicationController
  def search
    @books = []
    @title = params[:keyword]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      results.each do |result|
        @book = Book.new(read(result))
        @books << @book
      end
    end
  end

  private

  def read(result)
    title = result['title']
    author = result['author']
    isbn = result['isbn']
    {
      title: title,
      author: author,
      isbn: isbn,
    }

  end
end
