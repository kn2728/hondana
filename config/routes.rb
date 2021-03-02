Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'reads#index'
  resources :books do  #booksコントローラへのルーティング  
    resources :memos, only: [:create, :destroy]  #memosコントローラへのルーティング
    resources :summaries, only: [:index, :create, :new, :edit, :update]
  end
  resources :reads
end
