Rails.application.routes.draw do
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Root route
  root "articles#index"

  # Custom route for clapping
  put "/articles/:id/clap", to: 'articles#clap', as: "clap"

  # Resourceful routes for articles with a custom search action
  resources :articles do
    collection do
      get 'search'
    end
  end
end
