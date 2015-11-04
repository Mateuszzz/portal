require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
  end

  test "should not login a user" do   
    get login_path
    assert_template 'sessions/new'
    post login_path, email: "Tom", password: ""
    assert_redirected_to login_path
    assert_template 'sessions/new'
    assert_not flash.empty?  
  end
  
  test "should login a user and then logout him" do
    get login_path
    post login_path, email: @user.email, password: 'password'
    assert logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", user_path(@user), count: 1
    assert_select "a[href=?]", user_friendships_path(@user), count: 2
    delete logout_path
    assert_not logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end 
end