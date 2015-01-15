Rails.application.routes.draw do
  resource :user, except: [:destroy] do
    resources :posts, except: [:index, :new, :edit]
  end

  resources :posts, only: [:index] do
    resources :comments, except: [:index, :show]
  end

  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy, :new, :edit]

  root to: 'users#show'
end
