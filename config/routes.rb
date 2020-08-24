Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :users, only: [:edit, :update, :show]
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :bads, only: [:create, :destroy]
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :comgoods, only: [:create, :destroy]
      resources :combads, only: [:create, :destroy]
    end
  end
end
