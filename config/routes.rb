Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Define a resourceful route for articles
  resources :articles do
    # Adding the search route
    collection do
      get 'search', to: 'articles#search'
    end
  end

  # Set the root path to the articles index
  root to: 'articles#index'
end