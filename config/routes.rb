Rails.application.routes.draw do

  resources :articles
  root "articles#index"
  get "/articles#id", to: "articles#index"
  post "/articles", to: "articles#create"
  patch "/articles/:id", to: "articles#update"
end
