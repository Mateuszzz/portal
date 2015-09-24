require 'test_helper'

class PostDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @post = @user.posts.first
  end
  
  test "should delete a post" do
    log_in_as(@user)
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select '.alert.alert-success'
  end
  
end
