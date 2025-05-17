Rails.application.routes.draw do
  root "articles#index"

  get "/articles", to: "articles#index"
  get "/articles/search/", to: "articles#index"
  get "/articles/new", to: "articles#new"
  get "/articles/:id", to: "articles#show"
  get "/articles/:id/edit", to: "articles#edit"
  
  post "/articles", to: "articles#create"
end
