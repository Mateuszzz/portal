require 'test_helper'

class FriendshipsRejectTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @second_user = users(:mark)
  end
  
  test "should delete a user" do
    log_in_as(@user)
    assert_difference 'Friendship.count', -1 do
      delete user_friendship_path(@second_user.id, @second_user.id)
    end
    assert_redirected_to user_friendships_path(@user)
    follow_redirect!
    assert_template 'friendships/index'
    assert_select '.alert.alert-success', count: 1
  end  
end
