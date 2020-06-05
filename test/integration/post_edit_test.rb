require 'test_helper'

class PostEditTest < ActionDispatch::IntegrationTest
  def setup
    populate_db
    @user_one = User.first
    @user_two = User.last
    @post = Post.find_by(user_id: @user_one.id)
  end

  test 'should get edit post page' do 
    log_in_as(@user_one)
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

  test 'should not get edit post page because not logged in as author' do
    log_in_as(@user_two)
    get edit_post_path(@post)
    assert_response 302
    follow_redirect!

    assert_template "posts/index"
    assert_not flash.empty?
    assert_not flash[:danger].empty?
    assert_not flash[:success]
  end

  test 'should not update post because not logged in as author' do
    patch post_path(@post), params: { post: { title: "Yeah man!",
                                              body: "Boogie boogie." }}

    assert_response 302
    follow_redirect!
    assert_template 'posts/index'
    assert_not flash.empty?
    assert_not flash[:danger].empty?
  end

  test 'should update post' do  
    log_in_as(@user_one)                                      
    patch post_path(@post), params: { post: { title: "Yeah man!",
                                              body: "Boogie boogie." }}

    assert_response 302
    follow_redirect!

    @post.reload                                        
    assert_template 'posts/show'
    assert_equal @post.title, "Yeah man!"
    assert_equal @post.body, "Boogie boogie."                                  
  end

  test 'should not destroy post when not logged in as author' do
    id = @post.id.to_s
    delete post_path(@post)
    assert_response 302
    follow_redirect!

    assert_template 'posts/index'
    assert_not flash[:danger].empty?
    assert Post.find_by(id)

    log_in_as(@user_two)
    delete post_path(@post)
    assert_response 302
    follow_redirect!

    assert_template 'posts/index'
    assert_not flash[:danger].empty?
    assert Post.find_by(id: id)
  end

  test 'should destroy post' do
    id = @post.id.to_s
    log_in_as(@user_one)
    delete post_path(@post)
    assert_response 302
    follow_redirect!

    assert_template 'posts/index'
    assert_not flash[:success].empty?
    assert_not Post.find_by(id: id)
  end
end
