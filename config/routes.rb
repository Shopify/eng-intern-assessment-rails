Rails.application.routes.draw do
  # Articles routes - maintaining compatibility with original tests
  get 'articles/index'
  get 'articles/show'
  get 'articles/new'
  get 'articles/create'
  get 'articles/edit'
  get 'articles/update'
  get 'articles/destroy'
  
  # Additional routes for actual CRUD functionality with different names
  get 'articles/show/:id', to: 'articles#show', as: 'article_show'
  post 'articles/create', to: 'articles#create'
  get 'articles/edit/:id', to: 'articles#edit', as: 'article_edit'
  patch 'articles/update/:id', to: 'articles#update'
  delete 'articles/destroy/:id', to: 'articles#destroy'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "articles#index"
end
