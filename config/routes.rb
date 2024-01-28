Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    collection do
      get 'search'
    end
  end
end
