Rails.application.routes.draw do
  # route to home directory
  root "articles#index"

  # add search route 
  get '/search', to: "articles#search"
  
  # create, update, read, delete routes
  resources :articles
end
