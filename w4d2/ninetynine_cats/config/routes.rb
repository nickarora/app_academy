Rails.application.routes.draw do
  resources :cats do
  	resources :cat_rental_requests, only: [:new, :create], as: "rental_request"
  end
  resources :cat_rental_requests, only: :destroy do
    get 'approve' => 'cat_rental_requests#approve', as: 'approval'
    get 'deny' => 'cat_rental_requests#deny', as: 'denial'
  end

  root :to => "cats#index"

end
