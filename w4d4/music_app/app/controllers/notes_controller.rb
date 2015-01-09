class NotesController < ApplicationController

	before_action :verify_authorization, only: [:create, :destroy]

	def create
		@note = Note.new(note_params)
		@note.user_id = current_user.id

		track = Track.find(note_params[:track_id])

		@note.save
		redirect_to track_url(track)
	end

	def destroy
		@note = Note.find(params[:id])
		track = @note.track
		if current_user.id == @note.user_id
			@note.destroy
			redirect_to track_url(track)
		else
			render text: "403 Error", status: :forbidden
		end
		
	end

	private
	
	def note_params
		params.require(:note).permit(:content, :track_id)
	end

	def verify_authorization
		redirect_to login_url unless current_user
	end

end
