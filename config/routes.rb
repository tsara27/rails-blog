Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    resources :comments
  end
  resources :users
  root "articles#index"
end
