require 'test_helper'

class PostShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @post = @user.posts.first
  end
  
  test "post show" do
    get user_path(@user)
    assert_template 'users/show'
    get post_path(@post)
    assert_template 'posts/show'
    assert_select 'title', @user.name
    assert_select '.comment', count: @post.comments.count
    assert_match @post.title, response.body, count: 2
    assert_select '.form-inputs', count: 0
    assert_select '.login', count: 1
    
    log_in_as(@user)
    get post_path(@post)
    assert_template 'posts/show'
    assert_select '.form-inputs', count: 1
    assert_select '.login', count: 0
  end
end
