Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "articles#index"
  
  get "up" => "rails/health#show", as: :rails_health_check

  get "/articles", to: "articles#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
