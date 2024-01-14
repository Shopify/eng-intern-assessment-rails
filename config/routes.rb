Rails.application.routes.draw do

  resources :articles
  root "articles#index"
  post "/articles", to: "articles#create"
end
