Rails.application.routes.draw do

  # Custom Routes
  get 'articles/search', to: 'articles#search'
  get 'articles/title', to: 'articles#search_by_title'
  get 'articles/author', to: 'articles#search_by_author'

  # Standard REST routes
  resources :articles, only:[:index, :show, :create, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
