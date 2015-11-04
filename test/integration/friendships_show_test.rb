require 'test_helper'

class UserFriendshipsShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
    @second_user = users(:matt)
  end
  
  test "user friendships show" do
    get user_friendships_path(@user)
    assert_template 'friendships/index'
    assert_select '.received_invitations', count: 0
    assert_select '.pending_invitations', count: 0
    assert_select 'title', "Friends"
    assert_match "(#{@user.all_friends.count})", response.body
    @user.all_friends.each do |friend|
      assert_match friend.name, response.body
    end
    
    log_in_as(@user)
    get user_friendships_path(@user)
    assert_template 'friendships/index'
    assert_select '.received_invitations', count: 1
    assert_select '.pending_invitations', count: 1
    assert_select 'title', "Friends"
    assert_match "(#{@user.all_friends.count})", response.body
    @user.all_friends.each do |friend|
      assert_match friend.name, response.body
    end
    
    get user_friendships_path(@second_user)
    assert_template 'friendships/index'
    assert_select '.received_invitations', count: 0
    assert_select '.pending_invitations', count: 0
    assert_match "(#{@second_user.all_friends.count})", response.body
    @second_user.all_friends.each do |friend|
      assert_match friend.name, response.body
    end
  end 
end
