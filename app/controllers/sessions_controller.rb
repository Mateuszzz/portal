class SessionsController < ApplicationController
  
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
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end
  
end
