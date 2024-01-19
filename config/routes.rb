Rails.application.routes.draw do
  #Adding routes
  root "articles#index"

  # Adding routes for articles
  # new, create, edit, update, show, index, destroy
  resources :articles do
    # Adding a route for search
    collection do
      get :search
    end
  end
end
