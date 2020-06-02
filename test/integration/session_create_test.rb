require 'test_helper'

class SessionCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = User.first
  end

  test 'should not create session with invalid credentials' do 
    post login_path, params: { user: { email: 'dood@gmail.com', password: 'foob2@' }}

    assert_response 200
    assert_template 'sessions/new'

    post login_path, params: { user: { email: 'doodie@gmail.com', password: 'foob1!' }}

    assert_response 200
    assert_template 'sessions/new'
  end

  test 'should create session' do
    post login_path, params: { user: { email: 'dood@gmail.com', password: 'foob1!' }}

    assert_response 302
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert_not flash[:success].empty?
  end

  test 'should destroy session' do
    log_in_as(@user_one)
    follow_redirect!

    delete logout_path
    assert_response 302
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_not flash[:success].empty?
  end

  test 'should redirect when destroying non existent session' do
    delete logout_path
    assert_response 302
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_not flash[:danger].empty?
  end
end
