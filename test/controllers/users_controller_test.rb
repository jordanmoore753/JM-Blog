require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = User.first
  end

  test 'should get signup' do 
    get signup_path
    assert_response :success
    assert_template 'users/new'
  end

  test 'should not get signup if logged in' do
    log_in_as(@user_one)
    get signup_path
    assert_response 302
    follow_redirect!
    
    assert_template 'users/show' 
    assert flash[:danger]   
  end

  test 'should get edit' do
    log_in_as(@user_one)
    get edit_path
    assert_response :success
    assert_template 'users/edit'
  end

  test 'should not get edit when not logged in' do
    get edit_path
    assert_response 302
    follow_redirect!

    assert_template 'sessions/new'
    assert flash[:danger]
    assert_select 'title', 'Login | JM Blog'
  end
end
