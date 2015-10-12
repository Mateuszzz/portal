require 'test_helper'

class UserDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
  end
  
  test "should delete a user" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'main_pages/home'
    assert_select '.alert.alert-success'
  end  
end
