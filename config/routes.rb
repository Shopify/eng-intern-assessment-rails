Rails.application.routes.draw do
  resources :articles # Sett all necessary functions for articles

  root 'articles#index' # Set index function as root

  get 'articles/count', to: 'articles#count'

  # get 'articles/new', to: 'articles#new'
  # post 'articles', to: 'articles#create'

  # get 'articles/:id/edit', to: 'articles#edit', as: 'edit_article_by_id'
  # patch 'articles/:id', to: 'articles#update' - UNCOMMENT THIS

  get 'articles/search', to: 'articles#index', as: 'search_articles'

  get 'articles/:id', to: 'articles#show'

  # get 'articles/search', to: 'articles#search'

  # delete 'articles', to: 'articles#destroy'
  # delete 'articles/:id', to: 'articles#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
