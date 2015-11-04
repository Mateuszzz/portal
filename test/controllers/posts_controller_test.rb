require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  
  def setup
    extend ActionDispatch::TestProcess
    @user = users(:matt)
    @picture = fixture_file_upload('files/picture.jpg', 'image/jpg')
    @post = users(:john).posts.first
  end
  
  test "should redirect create when user not logged in" do
    assert_no_difference 'Post.count' do
      post :create, post: {title: "Holiday!", picture: @picture}
    end
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
  test "should redirect destroy when user not logged in" do
    assert_no_difference 'Post.count' do
      delete :destroy, id: @post
    end
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
  test "should redirect destroy when post is not user" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      delete :destroy, id: @post
    end
    assert_redirected_to @user
  end 
end
