Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Custom route for searching articles should come before 'resources :articles'
  get 'articles/search', to: 'articles#search', as: 'articles_search'

  root 'articles#index'

  # Standard RESTful routes for articles
  resources :articles

  # Defines the root path route ("/")
  # root "articles#index" # Suggested change for root path
end
