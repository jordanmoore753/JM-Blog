require 'test_helper'

class NavbarLinksTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = User.first
  end

  test 'should have logged out links' do 
    get root_path
    assert_template 'static_pages/index'
    assert_response 200
    assert_select 'title', 'Home | JM Blog'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', login_path, count: 1
    assert_select 'a[href=?]', logout_path, count: 0
    assert_select 'a[href=?]', signup_path, count: 2
    assert_select 'a[href=?]', posts_path, count: 1
  end

  test 'should have logged in links' do
    log_in_as(@user_one)
    get root_path
    assert_template 'static_pages/index'
    assert_response 200
    assert_select 'title', 'Home | JM Blog'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 1
    assert_select 'a[href=?]', signup_path, count: 0
    assert_select 'a[href=?]', posts_path, count: 1
    assert_select 'a[href=?]', profile_path, count: 1
  end
end
