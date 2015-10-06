require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    extend ActionDispatch::TestProcess
    @user = users(:john)
    @post = posts(:first)
    @comment =  @post.comments.build(user_id: 1, body: "Great picture!")
  end
  
   test "comment should be valid" do
      assert @comment.valid?
   end
   
  test "body should be present" do
    @comment.body = ""
    assert_not @comment.valid?
  end
  
  test "body should not be too long" do
    @comment.body = "a" * 401
    assert_not @comment.valid?
  end
  
   test "comments should be destroyed with post" do
     @comment.save
     assert_difference 'Comment.count', -1 do
       @post.destroy
     end
  end 
end
