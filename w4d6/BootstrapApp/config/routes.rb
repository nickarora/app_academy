AuthDemo::Application.routes.draw do

	root to: 'static_pages#home'
	
  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end

  get '/static_pages/home', to: 'static_pages#home', as: 'home'
  get '/static_pages/contact', to: 'static_pages#contact', as: 'contact'
  get '/static_pages/about', to: 'static_pages#about', as: 'about'

end


