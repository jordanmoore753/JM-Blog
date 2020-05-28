require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = Post.create!({ body: "This is my post.",
                           title: "Post 1",
                           author: "Author 1" })

    5.times do |n|
      Comment.create!({
        body: "This is the #{n}th comment.",
        author: "Author number #{n}",
        post_id: @post.id
      })
    end

    @comment = Comment.first
  end

  test "should get comment edit" do
    get edit_post_comment_url(@comment.post_id, @comment.id)
    assert_response :success
    assert_template "comments/edit"
    assert_select "title", "Edit Comment | JM Blog"
  end
end
