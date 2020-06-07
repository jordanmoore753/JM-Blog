require 'test_helper'

class PostIndexTest < ActionDispatch::IntegrationTest
  def setup
    populate_db
    @user_one = User.first
    @user_two = User.last
    @posts = Post.all.slice(0..4)
    @post = @posts.first
  end

  test 'should get index of all posts' do 
    get posts_url
    assert_response :success
    assert_template "posts/index"

    @posts.each do |post| 
      assert_select 'p.card-header-title', post.title, count: 1
    end

  end

  test 'should go to edit page for post' do
    get posts_url
    assert_response :success

    log_in_as(@user_two)
    get edit_post_url(@post)
    assert_response :success
    assert_template "posts/edit"
  end
end
