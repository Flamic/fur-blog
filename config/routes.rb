Rails.application.routes.draw do
  devise_for :users
  root to: redirect("articles#index")

  get 'about', to: 'about#index'

  resources :articles do
    resources :comments
  end
end
