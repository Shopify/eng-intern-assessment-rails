Rails.application.routes.draw do
  # Define the routes for the articles controller
  get 'articles/index'
  get 'articles/show'
  get 'articles/create'
  get 'articles/update'
  get '/search', to: "articles#search"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Define the root URL
  root 'articles#index'
  # Define the resources for articles
  resources :articles
end
