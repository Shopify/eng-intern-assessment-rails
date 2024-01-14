# frozen_string_literal: true

Rails.application.routes.draw do
  get 'api/v1/articles', to: 'api/v1/articles#index', as: :articles
  get 'api/v1/articles/new', to: 'api/v1/articles#new', as: :new_article
  get 'api/v1/articles/:id', to: 'api/v1/articles#show', as: :article
  get 'api/v1/articles/edit/:id', to: 'api/v1/articles#edit', as: :edit_article
  post 'api/v1/articles', to: 'api/v1/articles#create'
  patch 'api/v1/articles/:id', to: 'api/v1/articles#update'
  delete 'api/v1/articles/:id', to: 'api/v1/articles#destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Set root path as api/v1/articles to allow version control of the API
  root 'api/v1/articles#index'
end
