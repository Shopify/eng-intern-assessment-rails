Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "articles#index"
  
  get "/articles", to: "articles#index"
  get "/articles/:id", to: "articles#show"
end
