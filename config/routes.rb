Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  get '/post/tag/:name', to:"posts#tag"
  resources :users, only: [:edit, :update, :show] do
    get 'show_following'
    get 'show_follower'
    get 'show_article'
    get 'show_comment'
    get 'show_like'
    get 'show_question'
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts do
    collection do
      get 'search'
    end
    resources :likes, only: [:create, :destroy]
    resources :bads, only: [:create, :destroy]
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :comgoods, only: [:create, :destroy]
      resources :combads, only: [:create, :destroy]
    end
  end
end


