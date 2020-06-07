module PostsHelper
  def valid_user?(post)
    post.user_id == cookies.encrypted[:user_id] && request.env['PATH_INFO'] == '/profile'
  end

  def valid_user_comment?(comment)
    comment.user_id == cookies.encrypted[:user_id]
  end
end
