require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
  end
  describe "#index" do
    # 正常なレスポンスか？
    it "responds successfully" do
      sign_in @user
      get :index
      expect(response).to be_successful
    end
    # 200レスポンスが返ってきているか？
    it "returns a 200 response" do
      sign_in @user
      get :index
      expect(response).to have_http_status "200"
    end
  end
end
