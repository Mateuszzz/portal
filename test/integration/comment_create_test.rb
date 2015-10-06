require 'test_helper'

class CommentCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @post = @user.posts.first    
  end
  
  test "should not create a new comment" do
    log_in_as(@user)
    get post_path(@post)
    assert_no_difference 'Comment.count' do
      post post_comments_path(@post), comment: {body: ""}   
    end
    assert_redirected_to @post
    follow_redirect!
    assert_template 'posts/show'
    assert_select 'div.alert.alert-danger'
  end
  
  test "should create a new comment" do
    log_in_as(@user)
    get post_path(@post)
    assert_difference 'Comment.count', 1 do
      post post_comments_path(@post), comment: {body: "Holiday!"}   
    end
    assert_redirected_to @post
    follow_redirect!
    assert_template 'posts/show'
    assert_select 'div.alert.alert-danger', count: 0
  end
end
