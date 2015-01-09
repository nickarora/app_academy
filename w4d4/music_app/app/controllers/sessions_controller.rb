class SessionsController < ApplicationController
	
	def new
		@user = User.new
		render :new
	end

	def create
		@user =  User.new(session_params)

		if found_user = User.find_by_credentials(session_params[:email], session_params[:password])

			if found_user.activated
				login!(found_user)
				redirect_to bands_url
			else
				flash[:errors] = ["You must first activate your account!"]
				redirect_to bands_url
			end

		else
			flash[:errors] = ["Incorrect username and/or password"]
			render :new
		end
	end

	def destroy
		logout!
		redirect_to bands_url
	end

	private

	def session_params
		params.require(:session).permit(:email, :password)	
	end
end
