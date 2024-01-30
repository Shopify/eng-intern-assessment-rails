Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get "up" => "rails/health#show", as: :rails_health_check
  get "/articles/new", to:"articles#new", as: :article_new
  get "/articles/search", to: "articles#search", as: :search_articles
  get "/articles/:id", to: "articles#read", as: :article
  patch "/articles/:id", to: "articles#update"
  delete "/articles/:id", to: "articles#destroy"
  get "/articles/:id/edit", to:"articles#edit", as: :edit_article
  post "/articles", to: "articles#create", as: :articles
  # Defines the root path route ("/")
  root "articles#index"
end
