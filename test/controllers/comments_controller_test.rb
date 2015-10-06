require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  def setup
    @post = users(:john).posts.first
  end
  
  test "should redirect create when user not logged in" do
    assert_no_difference 'Comment.count' do
      post :create, post_id: @post, comment: {body: "Holiday!"}
    end
    assert_redirected_to login_path
  end
end