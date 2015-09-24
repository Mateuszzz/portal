class PostsController < ApplicationController
  before_action :authorize, only: [:create, :destroy]
  before_action :check_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = "Post created successfully!"
      redirect_to current_user
    else
      @user = User.find(current_user.id)
      @posts = @user.posts.paginate(page: params[:page], per_page: 6)
      render 'users/show'
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to current_user
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :picture)
  end
  
  def check_user
      @post = current_user.posts.find_by(id: params[:id])
      
      if @post.nil?
        redirect_to current_user
      end
  end
end
