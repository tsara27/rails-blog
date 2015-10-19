Rails.application.routes.draw do
  root "articles#index"
  get "/anynomous", to: "users#anynomous", as: :anon
  get "/tags/:tag", to: "articles#index", as: :tag

  devise_for :users
  resources :articles do
    resources :comments
  end
  resources :users do
    member do
      get :follwoing, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
end
