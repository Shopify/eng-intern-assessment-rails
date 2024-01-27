
Rails.application.routes.draw do
  # The root path is typically defined first, as it's the default page of your application.
  # The root path is set to the index action of the ArticlesController.
  root "articles#index"

  # Resourceful routes for articles. This provides RESTful routes to the articles resource.
  resources :articles

  # Custom route for health checks. It can be used by load balancers and uptime monitors.
  # It's placed after the standard resourceful routes, as it's a utility route for operational purposes.
  get "up" => "rails/health#show", as: :rails_health_check
end