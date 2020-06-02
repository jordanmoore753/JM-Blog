require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    populate_db
    @user_one = User.first
    @user_two = User.last
    @comment = Comment.find_by(user_id: @user_one.id)
  end

  test "should get comment edit" do
    log_in_as(@user_one)
    get edit_post_comment_url(@comment.post_id, @comment.id)
    assert_response :success
    assert_template "comments/edit"
    assert_select "title", "Edit Comment | JM Blog"
  end

  test 'should not get comment edit page without being logged in as author' do
    log_in_as(@user_two)
    get edit_post_comment_url(@comment.post_id, @comment.id)
    assert_response 302

    follow_redirect!
    assert_redirected_to post_path(@comment.post_id)
    assert_template "posts/show"
    assert_not flash[:danger].empty?
  end
end
