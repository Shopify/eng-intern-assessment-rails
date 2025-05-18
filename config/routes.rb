Rails.application.routes.draw do
	root 'articles#index'
	get 'new' => 'articles#new'
	resources :articles
end
