Rails.application.routes.draw do
  get 'articles', to:"articles#index"
  # get 'articles/new', to:"articles#create"
  get 'articles/:id', to:"articles#show"
  # get 'articles/edit', to:"articles#edit"
  # get 'articles/update', to:"articles#update"
  # get 'articles/destroy', to:"articles#destroy"

end
