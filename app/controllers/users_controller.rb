class UsersController < ApplicationController
  
  before_action :authorize, only: [:edit, :update]
  before_action :check_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Signup Successful!"
        redirect_to @user
    else
      render 'new'
    end
    
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(edit_user_params)
      
      if params[:user][:remove_avatar] == "1" && params[:user][:avatar].blank?
        remove_avatar(@user)
      end
      
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def edit_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
    
    def remove_avatar(user)
        user.avatar.destroy
        user.save
    end
  
end
