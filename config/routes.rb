Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end
  post '/graphql', to: 'graphql#execute'
  get 'articles/search', to: 'articles#search', as: 'search_articles'
  get 'search_page', to: 'articles#search_page'
  get 'articles/dashboard', to: 'articles#dashboard'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :articles do
  end

  root 'articles#index'

  get '/articles', to: 'articles#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ('/')
  # root 'posts#index'
end
