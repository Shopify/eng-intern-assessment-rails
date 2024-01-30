Rails.application.routes.draw do
  #defined RESTful routes for articles
  resources :articles

  #set the root route to articles#index
  root 'articles#index'
end
