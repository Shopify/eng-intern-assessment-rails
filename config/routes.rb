Rails.application.routes.draw do
  root 'articles#index'

  get '/search', to: 'articles#search'

  resources :articles
end
