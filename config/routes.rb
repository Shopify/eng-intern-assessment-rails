Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Set the root of the application to the index action of the ArticlesController
  root "articles#index"

  # Define RESTful routes for managing articles (index, show, new, create, edit, update, destroy)
  resources :articles
end
