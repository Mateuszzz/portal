require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:john)
    @second_user = users(:matt)
  end
  
  test "should not update a user profile" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template  'users/edit'
    patch user_path(@user), user: {name: "", email: "Tom@test.com", password: "password", password_confirmation: "password2" }
    assert_template 'users/edit'
  end
  
  test "should update a user profile" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Tom"
    email = "Tom@test.com"
    patch user_path(@user), user: {name: name, email: email, password: "password", password_confirmation: "password" }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
