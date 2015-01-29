Rails.application.routes.draw do

  root to: 'root#root'

  resources(
    :posts,
    defaults: {format: :json},
    only: [:create, :destroy, :index, :show, :update]
  )

end
