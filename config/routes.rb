Rails.application.routes.draw do
  devise_for :writers
  root 'articles#index'
  resources :articles
end
