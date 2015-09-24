class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user  

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    unless current_user
        flash[:danger] = "Please log in."
        redirect_to login_url
    end
  end
  
  def redirect
    unless !current_user
        redirect_to current_user
    end
  end
end
