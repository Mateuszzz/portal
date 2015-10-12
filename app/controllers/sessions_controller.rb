class SessionsController < ApplicationController
  before_action :redirect, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    
    if user && user.authenticate(params[:password])  
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end
  
  def destroy
    log_out
  end
end
