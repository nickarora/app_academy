Rails.application.routes.draw do
  root :to => "cats#index"

  resources :cats do
  	resources :cat_rental_requests, only: [:new, :create], as: "rental_request"
  end

  resources :cat_rental_requests, only: :destroy do
    member do
      post 'approve' => 'cat_rental_requests#approve', as: 'approval'
      post 'deny'    => 'cat_rental_requests#deny',    as: 'denial'
    end
  end

  resources :users,  only: [:new, :create, :show]

  resources :sessions, only: [:create, :destroy], as: 'session'

  get '/login' => 'sessions#new'
end
