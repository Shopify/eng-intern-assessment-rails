Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Add search route for articles
  resources :articles do
    collection do
      get 'search'
    end
  end
  
  # Default route
  root "articles#index"

  # Serve not_found page for any unmatched routes
  get "*unmatched_route", to: "errors#not_found"

end
