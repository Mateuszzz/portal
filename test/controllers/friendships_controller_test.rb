require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:john)
    @second_user = users(:mark)
    @third_user = users(:matt)
  end
  
  test "should redirect create when user not logged in" do
    assert_no_difference 'Friendship.count' do
      post :create, user_id: @second_user
    end
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
  test "should redirect update when user not logged in" do
    patch :update, user_id: @user, id: @user
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@user)
    patch :update, user_id: @third_user, id: @third_user
    assert_redirected_to @user
  end
  
  test "should redirect delete when user not logged in" do
    assert_no_difference 'Friendship.count' do
      delete :destroy, user_id: @user, id: @user
    end
    assert_not flash.empty?
    assert_redirected_to login_path
  end
  
  test "should redirect delete when logged in as wrong user" do
    log_in_as(@user)
    assert_no_difference 'Friendship.count' do
      delete :destroy, user_id: @third_user, id: @third_user
    end
    assert_redirected_to @user
  end
end 