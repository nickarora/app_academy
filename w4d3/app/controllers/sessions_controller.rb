class SessionsController < ApplicationController

  before_action :prevent_repeat_login, only: [:new]
  before_action :verify_authorization, only: [:destroy]

  def create
    user_name, password = session_params[:user_name], session_params[:password]
    @user = User.find_by_credentials(user_name, password)
    login_user! @user
    redirect_to cats_url
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    token = SessionToken.find(params[:id])
    if token.token == session[:token]
      logout_user!(token.user)
    else
      token.destroy
    end
    
    if current_user
      redirect_to user_url(current_user)
    else
      redirect_to cats_url
    end
  end

  private
    def session_params
      params.require(:session).permit(:user_name, :password)
    end

    def prevent_repeat_login
      redirect_to cats_url if current_user
    end

    def verify_authorization
      token = SessionToken.find(params[:id])
      redirect_to cats_url unless current_user && current_user.id == token.user_id
    end

end
