require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:john)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should redirect new when user logged in" do
    log_in_as(@user)
    get :new
    assert_redirected_to @user
  end
end
