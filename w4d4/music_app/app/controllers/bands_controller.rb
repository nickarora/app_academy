class BandsController < ApplicationController

	# 	  bands GET    /bands(.:format)                       bands#index
	#           POST   /bands(.:format)                       bands#create
	#  new_band GET    /bands/new(.:format)                   bands#new
	# edit_band GET    /bands/:id/edit(.:format)              bands#edit
	#      band GET    /bands/:id(.:format)                   bands#show
	#           PATCH  /bands/:id(.:format)                   bands#update
	#           PUT    /bands/:id(.:format)                   bands#update
	#           DELETE /bands/:id(.:format)                   bands#destroy

	before_action :verify_authorization, only: [:new, :create, :edit, :update, :destroy]

	def index
		@bands = Band.all
	end

	def show
		@band = Band.find(params[:id])
		@albums = @band.albums
	end
	
	def new
		@band = Band.new
	end

	def create
		@band = Band.new(band_params)
		if @band.save
			redirect_to bands_url
		else
			flash[:errors] = @band.errors.full_messages
			render :new
		end
	end

	def edit
		@band = Band.find(params[:id])
	end

	def update
		@band = Band.find(params[:id])

		if @band.update(band_params)
			redirect_to bands_url
		else
			flash[:errors] = @band.errors.full_messages
			render :edit
		end
	end

	def destroy
		@band = Band.find(params[:id])
		@band.destroy
		redirect_to bands_url
	end

	private

	def band_params
		params.require(:band).permit(:name)
	end

	def verify_authorization
		redirect_to login_url unless current_user
	end

end
