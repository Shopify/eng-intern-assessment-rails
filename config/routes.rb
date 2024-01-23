Rails.application.routes.draw do
  root 'articles#index'
  resources :articles
  get "up" => "rails/health#show", as: :rails_health_check
end
