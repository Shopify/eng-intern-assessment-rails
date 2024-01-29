Rails.application.routes.draw do
  resources :articles

  # Show the list of articles on the homepage
  root 'articles#index'

  # Redirects to a specific article
  get '/articles/:id', to: 'articles#show'

end
