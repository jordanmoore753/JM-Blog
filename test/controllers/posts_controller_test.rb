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
    assert_select 'title', 'Index | JM Blog'
    assert_template 'posts/index'
  end

  test 'should get edit' do
    get edit_post_url(@first_post)
    assert_response :success
    assert_select 'title', 'Edit | JM Blog'
    assert_template 'posts/edit'
  end

  test 'should get show' do
    get post_url(@first_post)
    assert_response :success
    assert_select 'title', 'Post 3 | JM Blog'
    assert_template 'posts/show'
  end
end
