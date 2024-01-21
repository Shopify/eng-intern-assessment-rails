Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "article#index"

  get "/article" => "article#index"

  get "/article/new" => "article#new"

  post "/article/new" => "article#create"

  get "/article/search" => "article#search"

  get "/article/:id" => "article#read"

  get "/article/:id/edit" => "article#edit"

  post "/article/:id/edit" => "article#update"

  delete "/article/:id" => "article#delete"
end
