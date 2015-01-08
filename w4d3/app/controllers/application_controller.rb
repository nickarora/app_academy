class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    token = SessionToken.find_by(token: session[:token])
    return token.user if token
    nil
  end

  def login_user!(user)
    token = user.store_new_token!(request_env)
    session[:token] = token.to_s
  end

  def logout_user!(user)
    user.destroy_token!(session[:token])
    session[:token] = nil
  end

  def request_ip
    request.remote_ip
  end

  def request_env
    user_agent = UserAgent.parse(request.env["HTTP_USER_AGENT"])
    user_agent.platform    
  end

end
