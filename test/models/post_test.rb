require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    extend ActionDispatch::TestProcess
    @user = users(:john)
    @picture = fixture_file_upload('files/picture.jpg', 'image/jpg')
    @post =  @user.posts.build(title: "Holiday!", picture: @picture)
  end
  
  test "post should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = ""
    assert_not @post.valid?
  end
  
  test "title should be present" do
    @post.title = ""
    assert_not @post.valid?
  end
  
  test "picture should be present" do
    @post.picture = nil
    assert_not @post.valid?
  end
  
  test "title should not be too long" do
    @post.title= "a" * 151
    assert_not @post.valid?
  end
  
end
