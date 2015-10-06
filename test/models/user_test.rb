require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    extend ActionDispatch::TestProcess
    @picture = fixture_file_upload('files/picture.jpg', 'image/jpg')
    @user = User.new(name: "Tom Test", email: "tom@test.com",
                     password: "password", password_confirmation: "password")
  end

  test "user should be valid" do
    assert @user.valid?
  end
  
  test "pass should be equals pass_com" do
    @user.password_confirmation = "pass2"
    assert_not @user.valid?
  end
  
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "password should be present" do
    @user.password = @user.password_confirmation = ""
  end
  
  test "name should not be too short" do
    @user.name = "aa"
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 76
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 248 + "@test.com"
    assert_not @user.valid?
  end
  
  test "password should not be too short" do
    @user.password = @user.password_confirmation = "aaaa"
    assert_not @user.valid?
  end
  
  test "password should not be too long" do
    @user.password = @user.password_confirmation = "a" * 41
    assert_not @user.valid?
  end
  
  test "invalid emails should be rejected" do
    emails = %w[tom@test,com tom.co.m tom.tom@test. tom@domen+domen.co.m]
    emails.each do |email|
      @user.email = email
      assert_not @user.valid?
    end
  end
  
  test "name should not be duplicate" do
    duplicate_user = @user.dup
    duplicate_user.email = "james@test.com"
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email address should not be duplicate" do
    duplicate_user = @user.dup
    duplicate_user.name = "James Test"
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "posts should be destroyed with user" do
    @user.save
    @user.posts.create(title: "Holiday!", picture: @picture)
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end 
end
