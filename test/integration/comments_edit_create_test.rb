require 'test_helper'

class CommentsEditCreateTest < ActionDispatch::IntegrationTest
  def setup
    populate_db
    @user_one = User.first
    @user_two = User.last
    @post = Post.find_by(user_id: @user_one.id)
    @comment = Comment.find_by(post_id: @post.id)
  end

  def comments_count
    Comment.all.length
  end

  test 'should not create comment without being logged in' do 
    orig_comments_size = comments_count
    post post_comments_path(@post.id), params: { comment: { body: "Whatever!" }}
    assert_response 302
    follow_redirect!

    assert_equal orig_comments_size, comments_count
    assert_template 'posts/show'
    assert flash[:danger]
  end

  test 'should create comment' do
    log_in_as(@user_one)
    orig_comments_size = comments_count

    post post_comments_path(@post.id), params: { comment: { body: "Whatever!" }}
    assert_response 302
    follow_redirect!
    
    new_comments_count = comments_count
    assert_template 'posts/show'
    assert flash[:success]
    assert_equal new_comments_count, orig_comments_size + 1
  end

  test 'should not update comment without being logged in as author' do
    patch post_comment_path(@comment.post_id, @comment.id), params: { comment: { body: 'What is good?' }}
    assert_response 302
    follow_redirect!

    @comment.reload
    assert_template 'posts/show'
    assert_not flash[:danger].empty?
    assert_not_equal @comment.body, 'What is good?'
  end

  test 'should update comment' do
    log_in_as(@user_one)
    patch post_comment_path(@comment.post_id, @comment.id), params: { comment: { body: 'What is good?' }}
    assert_response 302
    follow_redirect!

    @comment.reload
    assert_template 'posts/show'
    assert_not flash[:success].empty?
    assert_equal @comment.body, 'What is good?'
  end

  test 'should destroy comment' do
    log_in_as(@user_one)
    delete post_comment_path(@comment.post_id, @comment.id)
    assert_response 302
    follow_redirect!

    assert_template 'posts/show'
    assert_not flash[:success].empty?
    assert_not Comment.find_by(id: @comment.id)
  end

  test 'should not destroy comment because not logged in as author' do
    delete post_comment_path(@comment.post_id, @comment.id)
    assert_response 302
    follow_redirect!

    assert_template 'posts/show'
    assert_not flash[:danger].empty?
    assert_not flash[:success]
    assert Comment.find_by(id: @comment.id)

    log_in_as(@user_two)
    delete post_comment_path(@comment.post_id, @comment.id)
    assert_response 302
    follow_redirect!

    assert_template 'posts/show'
    assert_not flash[:danger].empty?
    assert_not flash[:success]
    assert Comment.find_by(id: @comment.id)
  end
end
