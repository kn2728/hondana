class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @books = []
    @title = params[:keyword]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
                                                        title: @title
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
    image_url = result['mediumImageUrl'].gsub('?_ex=120x120', '')
    {
      title: title,
      author: author,
      isbn: isbn,
      image_url: image_url
    }
  end
end
