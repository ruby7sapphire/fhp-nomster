Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'places#index'
	resources :places do
	  get 'page/:page', action: :index, on: :collection
		resources :comments, only: :create
		resources :photos
	end
  devise_for :users
	resources :users, only: :show
end
