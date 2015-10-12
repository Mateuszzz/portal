class UsersController < ApplicationController
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :redirect, only: [:new]
  
  def index
    if params[:search]
      @users = User.search(params[:search]).paginate(page: params[:page], per_page: 5)
    else
      @users = User.paginate(page: params[:page], per_page: 5)
    end
  end
  
  def show
    @user = User.find(params[:id])
    @post = current_user.posts.build if current_user == User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 9)
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
  
  def destroy
    @user.destroy
    flash[:success] = "User was successfully destroyed."
    log_out
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def edit_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end 
    
    def check_user
      @user = User.find(params[:id])
    
      unless @user == current_user
        redirect_to current_user
      end
    end
    
    def remove_avatar(user)
      user.avatar.destroy
      user.save
    end  
end
