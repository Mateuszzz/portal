class CommentsController < ApplicationController
  before_action :authorize, only: [:create]
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = "Comment added successfully!"
      redirect_to @post
    else
      flash[:danger] = "Comment can't be blank."
      redirect_to @post
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:user_id, :body)
  end
end
