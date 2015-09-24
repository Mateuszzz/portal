require 'test_helper'

class MainPagesControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:john)
  end
  
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end
  
  test "should redirect home when user logged in" do
    log_in_as(@user)
    get :home
    assert_redirected_to @user
  end

end
