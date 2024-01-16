Rails.application.routes.draw do
  resources :articles do
    collection do
      get 'search', to: 'articles#search'
    end
  end

  root "application#home"
end