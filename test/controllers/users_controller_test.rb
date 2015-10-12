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
  
  test "should redirect delete when user not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
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
