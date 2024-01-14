Rails.application.routes.draw do
  # Set default view to list of articles
  root 'articles#index'

  resources :articles

end
