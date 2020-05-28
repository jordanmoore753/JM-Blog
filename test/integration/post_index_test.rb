require 'test_helper'

class PostIndexTest < ActionDispatch::IntegrationTest
  def setup
    @post = Post.first
    @posts = Post.all
  end

  test 'should get index of all posts' do 
    get posts_url
    assert_response :success
    assert_template "posts/index"

    @posts.each { |post| assert_select 'h1.post_title', post.title, count: 1 }

    assert_select 'a.edit_post_link', count: 10
    assert_select 'a.read_post_link', count: 10
  end

  test 'should go to edit page for post' do
    get posts_url
    assert_response :success

    assert_select "div.article_#{@post.id}", count: 1 do
      assert_select "a.edit_post_link"
    end 

    get edit_post_url(@post)
    assert_response :success
    assert_template "posts/edit"
  end
end
