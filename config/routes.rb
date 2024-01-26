Rails.application.routes.draw do
  # route to home directory
  root "articles#index"

  # create, update, read, delete routes
  resources :articles
end
