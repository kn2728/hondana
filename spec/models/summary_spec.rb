require 'rails_helper'

RSpec.describe Summary, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book)
    user = @user
    book = @book
    @summary = FactoryBot.build(:summary, user_id: user.id, book_id: book.id)
  end
  describe 'まとめ入力' do
    context 'まとめ入力がうまくいく時' do
      it 'user_idとbook-id,matomeがある' do
        expect(@summary).to be_valid
      end
    end
    context 'まとめ入力がうまくいかない時' do
      it 'matomeが空' do
        @summary.matome = ''
        @summary.valid?
        expect(@summary.errors.full_messages).to include("Matomeを入力してください")
      end
      it 'matomeが字数を超えている' do
        @summary.matome = Faker::Lorem.characters(number: 801)
        @summary.valid?
        expect(@summary.errors.full_messages).to include("Matomeは800文字以内で入力してください")
      end
      it 'userがログインしていない' do
        @summary.user_id = ''
        @summary.valid?
        expect(@summary.errors.full_messages).to include("Userを入力してください")
      end
      it 'bookが指定できていない' do
        @summary.book_id = ''
        @summary.valid?
        expect(@summary.errors.full_messages).to include("Bookを入力してください")
      end
    end
  end
end
