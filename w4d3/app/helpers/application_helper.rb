module ApplicationHelper
  def current_token
    SessionToken.find_by(token: session[:token])
  end
end
