Rails.application.routes.draw do
  root "articles#index"

  resources :articles
  get '/search', to: "articles#search"
end
