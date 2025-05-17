Rails.application.routes.draw do
  devise_for :writers, controllers: {
    sessions: 'writers/sessions',
    registrations: 'writers/registrations'
  }
  root 'articles#index'
  resources :articles
end
