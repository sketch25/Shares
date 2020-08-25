Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  get '/post/tag/:name', to:"posts#tag"
  resources :users, only: [:edit, :update, :show] 
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


