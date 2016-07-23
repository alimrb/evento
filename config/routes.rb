Rails.application.routes.draw do
  resources :events
  resources :users, only: [ :new, :create, :update, :edit, :show ] do
	  member do
	    get :activate
	  end
  end
  resources :sessions
  
  root 'events#index'
  get 'login', to: 'sessions#new', as: :login
  get 'signup', to: 'users#new', as: :signup
  get 'logout', to: 'sessions#destroy', as: :logout

end
