class TracksController < ApplicationController
# new_album_track GET    /albums/:album_id/tracks/new(.:format) tracks#new
#          tracks POST   /tracks(.:format)                      tracks#create
#      edit_track GET    /tracks/:id/edit(.:format)             tracks#edit
#           track GET    /tracks/:id(.:format)                  tracks#show
#                 PATCH  /tracks/:id(.:format)                  tracks#update
#                 PUT    /tracks/:id(.:format)                  tracks#update
#                 DELETE /tracks/:id(.:format)                  tracks#destroy

	before_action :verify_authorization, only: [:new, :create, :edit, :update, :destroy]
	
	def show
		@track = Track.find(params[:id])
		@album = @track.album
		@band = @album.band
		
		render :show
	end

	def new
		@album = Album.find(params[:album_id])
		@band = @album.band
		@track = @album.tracks.new

		render :new
	end

	def create
		@track = Track.new(track_params)

		if @track.save
			redirect_to album_url(@track.album.id)
		else
			flash[:errors] = @track.errors.full_messages
			render :new
		end
	end

	def edit
		@track = Track.find(params[:id])
		@album = @track.album
		@band = @album.band

		render :edit
	end

	def update
		@track = Track.find(params[:id])
		@album = @track.album
		@band = @album.band

		if @track.update(track_params)
			redirect_to album_url(@album)
		else
			flash[:errors] = @track.errors.full_messages
			render :edit
		end
	end

	def destroy
		@track = Track.find(params[:id])
		@track.destroy
		redirect_to album_url(@track.album)
	end

	private
	
	def track_params
		params.require(:track).permit(:name, :version, :album_id, :lyrics)
	end

	def verify_authorization
		redirect_to login_url unless current_user
	end
	
end
