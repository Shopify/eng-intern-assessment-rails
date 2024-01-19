Rails.application.routes.draw do
  #Adding routes 
  root "articles#index"
  get "/articles", to: "articles#index"

  get "/articles/:id", to: "articles#show"
end
 