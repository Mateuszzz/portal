class FriendshipsController < ApplicationController
  before_action :authorize, only: [:create, :update, :destroy]
  before_action :check_friendship, only: [:update, :destroy]
  
  def index
    @user = User.find(params[:user_id])
    @friendships = @user.all_friends
  end
  
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id], accepted: "false")
    
    if @friendship.save
      flash[:success] = "Invitation was sent."
      redirect_to user_friendships_path(current_user)
    else
      flash[:danger] = "Invitation was not sent. Please try later."
      redirect_to user_friendships_path(current_user)
    end
  end
  
  def update
    @friendship.update(accepted: true)
    
    if @friendship.save
      flash[:success] = "Invitation was accepted."
      redirect_to user_friendships_path(current_user)
    else
      flash[:danger] = "Invitation was not accept. Please try later."
      redirect_to user_friendships_path(current_user)
    end
  end
  
  def destroy
    @friendship.destroy
    flash[:success] = "Invitation was rejected."
    redirect_to user_friendships_path(current_user)
  end
  
  private
  
    def check_friendship
      @friendship = Friendship.return_friendship(current_user, params[:user_id])
      
      if @friendship.nil?
        redirect_to current_user
      end     
    end  
end