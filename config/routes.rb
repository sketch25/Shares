Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :users, only: [:edit, :update]
  resources :posts do
    resources :comments, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
