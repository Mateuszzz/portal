require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:john)
    @second_user = users(:matt)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should redirect new when user logged in" do
    log_in_as(@user)
    get :new
    assert_redirected_to @user
  end
  
  test "should redirect edit when user not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when user not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@user)
    get :edit, id: @second_user
    assert_redirected_to @user
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@user)
    patch :update, id: @second_user, user: { name: @second_user.name, email: @second_user.email }
    assert_redirected_to @user
  end
  
  test "should redirect delete when user not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
   test "should redirect delete when account is not user" do
    log_in_as(@user) 
    assert_no_difference 'User.count' do
      delete :destroy, id: @second_user
    end
    assert_redirected_to @user
  end
end
