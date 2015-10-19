class FriendshipsController < ApplicationController
  before_action :authorize, only: [:create]
  
  def create
    @friendship = current_user.friendships.build(friendship_params)
    @friendship.accepted = "false"
    
    if @friendship.save
      flash[:success] = "Invite was sent."
      redirect_to :back
    else
      flash[:danger] = "Invite was not sent. Please try later."
      redirect_to :back
    end
  end
  
  private
  
    def friendship_params
      params.permit(:friend_id, :accepted)
    end
end