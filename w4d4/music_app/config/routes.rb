Rails.application.routes.draw do
  
  root to: 'bands#index'

  get '/login' => 'sessions#new'
  resource :session, only: [:create, :destroy]
  resources :users, only: [:index, :new, :create, :show] do
     get :activate, on: :collection
  end

  resources :bands do 
  	resource :albums, only: [:new], as: 'album'
  end
  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
  	resource :tracks, only: [:new], as: 'track'
  end
  resources :tracks, only: [:create, :edit, :show, :update, :destroy]
  
  resources :notes, only: [:create, :destroy]
end
