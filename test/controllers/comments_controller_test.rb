require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    populate_db
    @user_one = User.first
    @user_two = User.last
    @comment = Comment.first
  end

  test "should get comment edit" do
    get edit_post_comment_url(@comment.post_id, @comment.id)
    assert_response :success
    assert_template "comments/edit"
    assert_select "title", "Edit Comment | JM Blog"
  end
end
