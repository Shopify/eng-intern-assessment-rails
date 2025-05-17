Rails.application.routes.draw do
  # Defines the root path route ("/")
  resources :articles
  root "articles#index"
end
