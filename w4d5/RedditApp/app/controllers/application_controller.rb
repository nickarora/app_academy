class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find_by(session_token: session[:token])
  end

  def log_in!(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def log_out!
    current_user.reset_session_token! if current_user
    session[:token] = nil
  end

end
