class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logout!

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

end
