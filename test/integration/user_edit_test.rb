require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = User.first
  end

  test 'should not update when not logged in' do 
    patch edit_path, params: { user: { name: 'New Name',
                                       email: 'newemail@gmail.com',
                                       password: 'foob1!',
                                       password_confirmation: 'foob1!' }}

    assert_response 302
    follow_redirect!
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test 'should only update certain parameters' do
    log_in_as(@user_one)
    original_id = @user_one.id
    patch edit_path, params: { user: { name: 'New Name',
                                       email: 'newemail@gmail.com',
                                       id: 100,
                                       password: 'foob!1',
                                       password_confirmation: 'foob!1' }}

    assert_response 302
    follow_redirect!
    @user_one.reload

    assert_template 'users/show'
    assert_not flash.empty?
    assert_equal original_id, @user_one.id   
    assert_equal @user_one.name, 'New Name'
    assert_equal @user_one.email, 'newemail@gmail.com'                                      
  end

  test 'should update successfully' do
    log_in_as(@user_one)
    patch edit_path, params: { user: { name: 'New Name',
                                       email: 'newemail@gmail.com',
                                       password: 'foob!1',
                                       password_confirmation: 'foob!1' }}
                                                  

    assert_response 302
    follow_redirect!
    @user_one.reload

    assert_template 'users/show'
    assert_not flash.empty? 
    assert_equal @user_one.name, 'New Name'
    assert_equal @user_one.email, 'newemail@gmail.com'   
  end

  test 'should not update password because invalid' do
    log_in_as(@user_one)
    patch edit_path, params: { user: { name: 'New Name',
                                       email: 'newemail@gmail.com',
                                       password: 'foob' }}
                                                  

    assert_response 200
    assert_template 'users/edit'
    assert_not flash.empty?  
  end

  test 'should update password' do
    log_in_as(@user_one)
    patch edit_path, params: { user: { name: 'New Name',
                                       email: 'newemail@gmail.com',
                                       password: 'foob2@' }}
                                                  

    assert_response 302
    follow_redirect!

    assert_template 'users/show'
    assert_not flash.empty?  
    assert_not flash[:danger]
  end
end
