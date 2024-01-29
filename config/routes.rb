Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  # set Articles index page as the main page
  root 'articles#index'

  resources :articles
end
