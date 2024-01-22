Rails.application.routes.draw do
  resources :articles do
    collection do
      get 'search'
    end
  end

  root 'articles#index'
end
