require 'test_helper'

class PostIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user_one = User.first
    @user_two = User.last
  end

  test 'should get index of all posts' do 
    populate_db
    @posts = Post.all.slice(0..4)
    @post = @posts.first

    get posts_url
    assert_response :success
    assert_template "posts/index"

    @posts.each do |post| 
      assert_select 'p.card-header-title', post.title, count: 1
    end

  end

  test 'should go to edit page for post' do
    populate_db
    @posts = Post.all.slice(0..4)
    @post = @posts.first

    get posts_url
    assert_response :success

    log_in_as(@user_two)
    get edit_post_url(@post)
    assert_response :success
    assert_template "posts/edit"
  end

  test 'should go to posts index and show no posts' do
    get posts_url
    assert_response :success
    assert_template "posts/index"
    assert_select 'p', 'No posts.'
  end
end
