Rails.application.routes.draw do
  get 'searches/search'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'reads#index'

  namespace :api, format: 'json' do
    namespace :v1 do
      resources :books, only: [:index, :show, :create, :update, :destroy]
    end
  end

  resources :books do  #booksコントローラへのルーティング  
    resources :memos, only: [:create, :destroy]  #memosコントローラへのルーティング
    resources :summaries, only: [:index, :create, :new, :edit, :update]
  end
  resources :reads
end
