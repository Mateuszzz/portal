require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:john)
    @second_user = users(:mark)
    @friendship = @user.friendships.build(friend_id: @second_user.id, accepted: "false" )
  end
  
  test "friendship should be valid" do
    assert @friendship.valid?
  end
  
  test "friendship should be unique" do
    @friendship.save
    friendship2 = @user.friendships.build(friend_id: @second_user.id, accepted: "false" )
    assert_not friendship2.valid?
  end
  
  test "friend_id should be present" do
    @friendship.friend_id = ""
    assert_not @friendship.valid?
  end
  
  test "accepted should be present" do
    @friendship.accepted = ""
    assert_not @friendship.valid?
  end
  
  test "user_id should not equal friend_id" do
    @friendship.friend_id = @user.id
    assert_not @friendship.valid?
  end  
end
