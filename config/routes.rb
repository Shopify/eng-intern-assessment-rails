Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "articles#index"
  
  # Defines the routes for articles
  resources :articles
end
