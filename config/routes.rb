Rails.application.routes.draw do
  devise_for :writers, controllers: {
    sessions: 'writers/sessions',
    registrations: 'writers/registrations'
  }
  devise_scope :writer do
    get 'writers/sign_out', to: 'writers/sessions#sign_out'
  end
  root 'articles#index'
  resources :articles
end
