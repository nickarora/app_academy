class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
  	user = User.find_by(session_token: session[:token])
  	return user if user
  	nil
  end

  def login!(user)
  	user.reset_session_token!
  	session[:token] = user.session_token
  end

  def logout!
  	current_user.reset_session_token!
  	session[:token] = nil
  end

end
