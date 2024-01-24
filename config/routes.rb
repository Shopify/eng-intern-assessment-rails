# frozen_string_literal: true

Rails.application.routes.draw do
  get 'comments/create'
  # Defines the root path route ("/")
  # TODO: Landing page with link to article list page
  root "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :articles do
    resources :comments, only: [:create, :destroy]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
