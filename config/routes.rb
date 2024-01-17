Rails.application.routes.draw do
  root "articles#index"
  resources :articles, format: false
end
