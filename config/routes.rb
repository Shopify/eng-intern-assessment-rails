# https://guides.rubyonrails.org/routing.html#adding-collection-routes
Rails.application.routes.draw do
  root "articles#landing"

  resources :articles do
    collection do
      get 'search'
    end
  end
end
