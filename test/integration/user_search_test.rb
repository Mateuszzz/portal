require 'test_helper'

class UsersSearchTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    if User.count > 5
      @user_count = 5
    else
      @user_count = User.count
    end
  end
  
  test "should find correct user" do
    get users_path
    assert_template 'users/index'
    assert_select 'ul.users li', count: @user_count
    get users_path, search: @user.name
    assert_template 'users/index'
    assert_select 'ul.users li', count: 1
    assert_select 'a[href=?]', user_path(@user), text: @user.name
  end 
end
