Rails.application.routes.draw do
  
  # Sets the root of the application to the articles index page.
  root "articles#index"
  
  # Generates RESTful routes for managing articles, including create, read, update, and delete actions.
  resources :articles

end
