Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "articles#index"

  # Defines all CRUD routes
  resources :articles

  # Article Searching
  get 'search', to: 'articles#search', as: 'search_articles'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
