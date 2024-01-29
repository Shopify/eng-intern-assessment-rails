Rails.application.routes.draw do
  # get 'articles/index'
  # get 'articles/new'
  
  # get 'articles/edit'
  # get 'articles/show'
  # get 'articles/delete'

  
  
  # get 'index/show'
  # get 'index/new'
 #  get 'index/edit'
  # get 'index/delete'


  # get 'categories/index'
  # get 'categories/show'
  # get 'categories/new'
  # get 'categories/edit'
  # get 'categories/delete'


  root "main#index"

  match 'about', to:"main#about",via: :get
  match 'hello', to:"main#hello",via: :get
  get 'main/index'
  
  resources :categories do
    member do
      get :delete
    end
  end
  
  resources :articles do
    member do
      get :delete
    end
  end
 
  resources :tasks do
    member do
      get :delete
    end
  end







  # get 'tasks/index'
  # get 'tasks/new'
  # get 'tasks/edit'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
