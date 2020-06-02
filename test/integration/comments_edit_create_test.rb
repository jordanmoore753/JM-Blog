require 'test_helper'

class CommentsEditCreateTest < ActionDispatch::IntegrationTest
  def setup
    populate_db
    @user_one = User.first
    @user_two = User.last
    @post = Post.find_by(user_id: @user_one.id)
  end

  test 'should not create comment without being logged in' do 

  end

  test 'should create comment' do

  end

  test 'should not update comment without being logged in as author' do

  end

  test 'should update comment' do

  end
end
