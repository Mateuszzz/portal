require 'test_helper'

class FriendshipsAcceptTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @second_user = users(:mark)
  end
  
  test "should accept a friendship" do
    log_in_as(@user)
    patch user_friendship_path(@second_user.id, @second_user.id)
    assert_redirected_to user_friendships_path(@user)
    follow_redirect!
    assert_template 'friendships/index'
    assert_select 'div.alert.alert-success', count: 1
    @second_user.reload
    assert_equal true, @second_user.friendships.first.accepted
  end  
end
