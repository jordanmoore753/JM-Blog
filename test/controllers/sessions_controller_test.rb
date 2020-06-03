require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = User.first
  end

  test 'should get login' do 
    get login_path
    assert_response :success
    assert_template 'sessions/new'
  end

  test 'should not get login' do
    log_in_as(@user_one)
    get login_path
    assert_response 302
    assert_template 'users/show'
    assert_not flash[:danger].empty?
  end
end
