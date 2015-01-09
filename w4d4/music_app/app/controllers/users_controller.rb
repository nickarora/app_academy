class UsersController < ApplicationController
	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			flash[:notice] = ["Successfully created your account! Check your inbox for an activation email."]
			redirect_to bands_url
		else
			flash.now[:errors] = @user.errors.full_messages
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
		render :show
	end

	def activate
		@user = User.find_by_activation_token(params[:activation_token])
  	@user.activate!
  	login!(@user)
  	flash[:notice] = ["Successfully activated your account!"]
    redirect_to bands_url
	end

	private
	def user_params
		params.require(:user).permit(:email, :password)
	end
end
