class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_user_profile?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_user_profile?(user)
    current_user == user
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
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end 
end
