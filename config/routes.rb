Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "articles#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes to added article functionality
  get "/articles", to: "articles#index"
  get "/articles/search/:search_query", to: "articles#search"
  resources :articles # default CRUD

  # Defines the root path route ("/")
  # root "posts#index"
end
