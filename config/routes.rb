Rails.application.routes.draw do
  get 'attachments/show'
  get 'attachments/create'
  devise_for :users
  root to: redirect("articles#index")

  get 'about', to: 'about#index'

  resources :articles do
    resources :comments
  end
end
