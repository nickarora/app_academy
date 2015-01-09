class AlbumsController < ApplicationController

 # new_band_album GET    /bands/:band_id/albums/new(.:format)   albums#new
 #         albums POST   /albums(.:format)                      albums#create
 #     edit_album GET    /albums/:id/edit(.:format)             albums#edit
 #          album GET    /albums/:id(.:format)                  albums#show
 #                PATCH  /albums/:id(.:format)                  albums#update
 #                PUT    /albums/:id(.:format)                  albums#update
 #                DELETE /albums/:id(.:format)                  albums#destroy

 before_action :verify_authorization, only: [:new, :create, :edit, :update, :destroy]
 
 def show
 	@album = Album.find(params[:id])
 	@band = @album.band
 	@tracks = @album.tracks
 end
 
 def new
 	@band = Band.find(params[:band_id])
 	@album = @band.albums.new

 	render :new
 end

 def create
 	@album = Album.new(album_params)
 	@band = Band.find(album_params[:band_id])

 	if @album.save
 		redirect_to band_url(@album.band.id)
 	else
 		flash[:errors] = @album.errors.full_messages
 		render :new
 	end
 end

 def edit
 	@album = Album.find(params[:id])
 	@band = @album.band
 	render :edit
 end

 def update
 	@album = Album.find(params[:id])
 	@band = @album.band

 	if @album.update(album_params)
 		redirect_to band_url(@album.band.id)
 	else
 		flash[:errors] = @album.errors.full_messages
 		render :edit
 	end
 end

 def destroy
 	@album = Album.find(params[:id])
 	@album.destroy
 	redirect_to band_url(@album.band.id)
 end

 private

 def album_params
 	params.require(:album).permit(:name, :recording_type, :band_id)
 end

 	def verify_authorization
		redirect_to login_url unless current_user
	end

 
end
