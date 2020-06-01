require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get signup' do 
    get signup_path
    assert_response :success
    assert_template 'users/new'
  end

  test 'should not get signup if logged in' do
    # log in
    get signup_path
    assert_response 302
    assert_template 'users/show'    
  end

  test 'should get edit' do
    # log in
    get edit_path
    assert_response :success
    assert_template 'users/edit'
  end

  test 'should not get edit when not logged in' do
    # no log in
    get edit_path
    assert_response 302
    assert_template 'sessions/new'
  end
end
