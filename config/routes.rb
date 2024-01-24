Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # Sets root (home) path of the application
  # When someone visits the base URL of the app, they will be directed to the 'index' action of the articles controller
  root 'articles#index'
  resources :articles

  resources :articles do
    # Used to add routes that action on the collection
    collection do
      # 'Search' route to the collection
      # Routed to the search action in the articles controller
      get :search
    end
  end

end
