Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    resources :comments
  end
  resources :users do
    member do
      get :follwoing, :followers
    end
  end
  root "articles#index"

  resources :relationships, only: [:create, :destroy]
end
