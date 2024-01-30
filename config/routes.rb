Rails.application.routes.draw do
  root "articles#index"

  # Routes CRUD operations for articles
  resources :articles
end
