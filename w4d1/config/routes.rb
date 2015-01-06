Rails.application.routes.draw do
  resources :users, only: [:index, :create, :destroy, :show, :update] do
    resources :contacts, only: :index
  end
  resources :contacts, only: [:create, :destroy, :show, :update]


  resources :contact_shares, only: [:create, :destroy]

  # get 'users' => 'users#index', :as => 'users'
  # post 'users' => 'users#create'
  # get 'users/new' => 'users#new', :as => 'new_user'
  # get 'users/:id/edit' => 'users#edit', :as => 'edit_user'
  # get 'user/:id' => 'users#show', :as => 'user'
  # patch 'user/:id' => 'users#update'
  # put 'user/:id' => 'users#update'
  # delete 'user/:id' => 'users#destroy'

end
