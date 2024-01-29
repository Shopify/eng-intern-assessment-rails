Rails.application.routes.draw do
  root "articles#index"

  # get "articles", to: "articles#index"
  # get "/articles/:id", to: "articles#show"
  # replacing get functionality with resources
  # Added search route as collection as it acts on the entire object and not a specific instance
  resources :articles do
    collection do
      get "search"
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
