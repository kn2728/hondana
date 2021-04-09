require 'rails_helper'

RSpec.describe Memo, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book)
    user = @user
    book = @book
    @memo = FactoryBot.build(:memo, user_id: user.id, book_id: book.id)
  end
  describe 'メモ入力' do
    context 'メモ入力がうまくいく時' do
      it 'user_idとbook-id,contentがある' do
        expect(@memo).to be_valid
      end
    end
    context 'メモ入力がうまくいかない時' do
      it 'contentが空' do
        @memo.content = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include("Contentを入力してください")
      end
      it 'contentが字数を超えている' do
        @memo.content = Faker::Lorem.characters(number: 141)
        @memo.valid?
        expect(@memo.errors.full_messages).to include("Contentは140文字以内で入力してください")
      end
      it 'userがログインしていない' do
        @memo.user_id = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include("Userを入力してください")
      end
      it 'bookが指定できていない' do
        @memo.book_id = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include("Bookを入力してください")
      end
    end
  end
end
