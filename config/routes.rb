Rails.application.routes.draw do
  root "articles#index" # set root to direct to index method of articles_controller
  resources :articles # sets up routes for articles automatically
end
