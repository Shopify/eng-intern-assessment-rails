Rails.application.routes.draw do
  # Define RESTful routes for articles, including a custom search route
  resources :articles do
    collection do
      get 'search', to: 'articles#search'
    end
  end

  # Set the root route to the home action of the ApplicationController
  root "application#home"
end