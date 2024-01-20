Rails.application.routes.draw do
  root "articles#index"

  # all basic routes for CRUD operations
  resources :articles
  # search route
  get '/search', to: "articles#search"
end
