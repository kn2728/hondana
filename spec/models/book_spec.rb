require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.build(:book)
  end
  describe 'book登録' do
    context 'うまくいく時' do
      it 'title,autor,isbnがある' do
        user = @user
        expect(@book).to be_valid
      end
    end
    context 'うまくいかない時' do
      it 'titleがない' do
        user = @user
        @book.title = ''
        @book.valid?
        expect(@book.errors.full_messages).to include('Titleを入力してください')
      end
      it 'authorがない' do
        user = @user
        @book.author = ''
        @book.valid?
        expect(@book.errors.full_messages).to include('Authorを入力してください')
      end
      it 'isbnがない' do
        user = @user
        @book.isbn = ''
        @book.valid?
        expect(@book.errors.full_messages).to include('Isbnを入力してください')
      end
    end
  end
end
