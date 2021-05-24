Rails.application.routes.draw do
  root to: redirect("articles#index")

  get 'about', to: 'about#index'

  resources :articles do
    resources :comments
  end

  get "/articles/:title", to: "articles#index"
end
