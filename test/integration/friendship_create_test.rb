require 'test_helper'

class FriendshipCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @second_user = users(:mark)
  end
  
  test "should accept a friendship" do
    log_in_as(@user)
    assert_difference 'Friendship.count', +1 do
      post user_friendships_path(@second_user, @second_user)
    end
    assert_redirected_to user_friendships_path(@user)
    follow_redirect!
    assert_template 'friendships/index'
    assert_select 'div.alert.alert-success', count: 1
  end  
end
