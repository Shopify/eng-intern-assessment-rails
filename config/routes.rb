Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "articles#index"

  # Defines a resourceful route for articles which includes auto-generated routes like /articles/new
  resources :articles
end
