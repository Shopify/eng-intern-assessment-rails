Rails.application.routes.draw do
  resources :articles do
    collection do
      get 'search' # Adds a search route for articles
    end
  end

  # Sets the root route to the articles index
  root 'articles#index'
end
