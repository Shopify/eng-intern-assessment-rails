Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "articles#index"

  # makes index, new, create, show, edit, update, and destroy routes
  resources :articles do
    collection do
      get :search
    end
  end
end
