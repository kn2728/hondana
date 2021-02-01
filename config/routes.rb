Rails.application.routes.draw do
  resources :memos
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'books#index'
  resources :books do  #postsコントローラへのルーティング  
    resources :memos, only: [:create]  #commentsコントローラへのルーティング
  end
end
