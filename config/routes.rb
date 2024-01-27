Rails.application.routes.draw do
  # Define the root path of the application to the index action of articles controller
  root "articles#index"

  # Resource routing for articles to automatically create routes for standard CRUD operations
  resources :articles
end