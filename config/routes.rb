Rails.application.routes.draw do
  root "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # user actions
  devise_for :users
  as :user do
    get "signin" => 'devise/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # article actions
  resources :articles
  get '/article_search' , to: 'articles#article_search', as: 'article_search'
  get "create_article" => 'articles#new'
  delete "delete_article/:id" => 'articles#destroy', as: 'delete_article'
  get '/article_repository', to: 'articles#article_repository', as: 'article_repository'
end
