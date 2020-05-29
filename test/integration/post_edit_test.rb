require 'test_helper'

class PostEditTest < ActionDispatch::IntegrationTest
  def setup
    populate_db
    @user_one = User.first
    @user_two = User.last
    @post = Post.first
  end

  test 'should get edit post page' do 
    get edit_post_path(@post)
    assert_response :success
    assert_select "title", "Edit Article | JM Blog"
    assert_template "posts/edit"

    assert_select "input[name=post_title]" do
      assert_select "[value=?]", @post.title
    end

    assert_select "input[name=post_author}]" do
      assert_select "[value=?]", @post.author
    end
  end

  test 'should update post' do                                        
    patch post_path(@post), params: { post: { title: "Yeah man!",
                                              body: "Boogie boogie.",
                                              author: "Author Man" }}

    assert_response 302
    @post.reload                                        
    assert_redirected_to post_path(@post)
    assert_equal @post.title, "Yeah man!"
    assert_equal @post.body, "Boogie boogie."
    assert_equal @post.author, "Author Man"                                      
  end
end
