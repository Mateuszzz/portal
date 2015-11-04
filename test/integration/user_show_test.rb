require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @second_user = users(:matt)
    @third_user = users(:james)
  end
  
  test "user profile show" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select '.post', count: 0
    assert_select '.invite', count: 0
    assert_select 'a', text: "Delete", count: 0
    assert_select 'title', @user.name
    assert_select '.information b', text: @user.name
    assert_match "#{@user.posts.count} posts", response.body
    assert_select '.image img', count: @user.posts.paginate(page: 1).count
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.title, response.body
    end
    
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!
    assert_select '.post'
    assert_select '.invite', count: 0
    assert_select 'a', text: "Delete"
    get user_path(@second_user)
    assert_select '.post', count: 0
    assert_select 'a', text: "Delete", count: 0
    get user_path(@third_user)
    assert_select '.invite', count: 1
  end 
end
