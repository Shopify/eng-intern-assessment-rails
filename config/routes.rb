Rails.application.routes.draw do
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # get 'articles', to: 'articles#index', as: :articles
  get 'random_article', to: 'articles#random', as: :random_article

  # Defines the root path route ("/")
  root "articles#index"

  get 'all', to: 'articles#all', as: :all_articles
end
