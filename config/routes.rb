Rails.application.routes.draw do
  root "articles#index"
  get '/search', to: "articles#search"
  resources :articles
  get "up" => "rails/health#show", as: :rails_health_check
end
