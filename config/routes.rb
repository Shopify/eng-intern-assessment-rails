Rails.application.routes.draw do
  get 'welcome/index'
  
  # Other routes...

  # Set the root route
  root 'welcome#index'

  # Article resources
  resources :articles

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Other routes, if any...
end
