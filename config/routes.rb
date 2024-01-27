Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "articles#index"

  resources :articles do 
    collection do 
      get 'search'
    end 
  end 

  # Route errors to ErrorsController
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'

  # Catch-all route 
  get '*path', to: 'errors#not_found'
end