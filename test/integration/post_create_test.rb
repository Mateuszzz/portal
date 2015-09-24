require 'test_helper'

class PostCreateTest < ActionDispatch::IntegrationTest
 
  def setup
    extend ActionDispatch::TestProcess
    @user = users(:john)
    @picture = fixture_file_upload('files/picture.jpg', 'image/jpg')
    @post = posts(:first)
  end
  
  test "should not create a new post" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      post posts_path, post: {title: "", picture: ""}   
    end
    assert_template 'users/show'
    assert_select 'div.error_explanation'
  end
  
  test "should create a new post" do
    log_in_as(@user)
    title = "Holiday!"
    assert_difference 'Post.count', 1 do
      post posts_path, post: {title: title, picture: @picture}   
    end
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div.error_explanation', count: 0
    assert_match title, response.body
  end
 
end
