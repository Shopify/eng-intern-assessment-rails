Rails.application.routes.draw do

  resources :articles
  root "articles#index"
  post "/articles", to: "articles#create"
  patch "/articles/:id", to: "articles#update"
end
