Rails.application.routes.draw do
  root to: redirect("articles#index")

  resources :articles do
    resources :comments
  end
end
