Rails.application.routes.draw do
  root "articles#index"

  # get method for c, u, d, index, show, etc
  resources :articles 

  end
  

