require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    populate_db
    @user_one = User.first
    @user_two = User.last
    @first_post = Post.first
  end

  test 'should get index' do
    get posts_url
    assert_response :success
    assert_select 'title', 'Posts | JM Blog'
    assert_template 'posts/index'
  end

  test 'should get edit' do
    log_in_as(@user_one)
    get edit_post_url(@first_post)
    assert_response :success
    assert_select 'title', 'Edit Post | JM Blog'
    assert_template 'posts/edit'
  end

  test 'should not get edit' do
    get edit_post_url(@first_post)
    assert_response 302
    follow_redirect!
    assert_select 'title', 'Posts | JM Blog'
    assert_template 'posts/index'
    assert flash[:danger]
  end

  test 'should get show' do
    get post_url(@first_post)
    assert_response :success
    assert_template 'posts/show'
  end
end
