Rails.application.routes.draw do
  # ... existing routes ...

  # Route for health check (already present)
  get "up" => "rails/health#show", as: :rails_health_check

  # Resource route for articles, providing RESTful routes for CRUD operations
  resources :articles

  # Optionally, you can set the root path to the articles index action
  # This means visiting '/' will take the user to the list of articles
  root "articles#index"
end
