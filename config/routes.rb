Rails.application.routes.draw do
  root 'articles#index'

  get 'articles/index', to: "articles#index"
  resources :articles

  get "up" => "rails/health#show", as: :rails_health_check

end
