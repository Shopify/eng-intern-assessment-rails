Rails.application.routes.draw do
  
  # setting articles index as landing apge
  root "articles#index"

  # # map articles url to corresponding method which renders corresponding view
  # get "/articles", to: "articles#index"
  # get "/articles/:id", to: "articles#show"

  # use build-in crud routes, use only/except + do to customize it
  resources :articles do
    collection do
      get :search
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
