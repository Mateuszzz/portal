require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  
  test "should not create new user" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "Tom", email: "Tom@test.com", password: "password", password_confirmation: "pass" }
    end
    assert_template 'users/new'
    assert_select 'div.alert.alert-danger'
    assert_not flash[:success]
  end
  
  test "should create new user" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name: "Tom", email: "Tom@test.com", password: "password", password_confirmation: "password" }
    end
    assert_redirected_to user_path(assigns(:user))
    assert_select 'div.alert.alert-danger', count: 0
    assert flash[:success]
  end
  
end
