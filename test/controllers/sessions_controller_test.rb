require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup

  end

  test 'should get login' do 
    get login_path
    assert_response :success
    assert_template 'users/show'
  end

  test 'should not get login' do
    # log in 
    get login_path
    assert_response 302
    assert_template 'users/show'
  end
end
