Rails.application.routes.draw do
  root 'articles#index'

  # Resourceful routes for articles with an additional search route.
  resources :articles do
    collection do
      get 'search', to: 'articles#search'
    end
  end

  # Additional route to alias /articles to the articles index for convenience.
  get 'articles', to: 'articles#index', as: 'articles_index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
