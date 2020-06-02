require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = User.first
  end

  test 'should not create user with duplicate email' do 
    post signup_path, params: { user: { name: 'jondan', email: 'dood@gmail.com', password: 'foob1!', password_confirmation: 'foob1!' }}

    assert_response 200
    assert_template 'users/new'
    assert_not flash.empty?
    assert_not flash[:danger].nil?
  end

  test 'should not create user without fields' do
    post signup_path, params: { user: { name: 'jondan', password: 'foob1!', password_confirmation: 'foob1!' }}

    assert_response 200
    assert_template 'users/new'
    assert_not flash.empty?
    assert_not flash[:danger].nil?
  end

  test 'should not create user with invalid password' do
    post signup_path, params: { user: { name: 'jondan', email: 'doodie@gmail.com', password: 'foob', password_confirmation: 'foob' }}

    assert_response 200
    assert_template 'users/new'
    assert_not flash.empty?
    assert_not flash[:danger].nil?
  end

  test 'should not create user with non matching passwords' do
    post signup_path, params: { user: { name: 'jondan', email: 'doodie@gmail.com', password: 'foob1!', password_confirmation: 'foob2@' }}

    assert_response 200
    assert_template 'users/new'
    assert_not flash.empty?
    assert_not flash[:danger].nil?
  end

  test 'should not create user if logged in' do
    log_in_as(@user_one)

    post signup_path, params: { user: { name: 'jondan', email: 'doodie@gmail.com', password: 'foob1!', password_confirmation: 'foob1!' }}

    assert_response 302
    assert_template 'users/show'
    assert_not flash.empty?
    assert_not flash[:danger].nil?
  end

  test 'should create user' do
    post signup_path, params: { user: { name: 'jondar', email: 'doodie@gmail.com', password: 'foob1!', password_confirmation: 'foob1!' }}

    assert_response 302
    follow_redirect!
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert flash[:danger].nil?
    assert_not flash[:success].nil?
  end
end
