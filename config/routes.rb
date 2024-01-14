Rails.application.routes.draw do

  resources :articles, only: [:new, :create]
  root "articles#index"

  post "/artciles/new", to: "articles#new"
  post "/articles", to: "articles#create"
end
