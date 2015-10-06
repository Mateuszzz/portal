require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do
    get root_path
    assert_template 'main_pages/home'
    assert_select "title", "Home"
    assert_select "a[href=?]", home_path, count: 2
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a.btn.btn-lg.btn-primary"
    
    get signup_path
    assert_template 'users/new'
    assert_select "title", "Sign up"
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path, count: 1
    assert_select "a.btn.btn-lg.btn-primary", count: 0
  end
end
