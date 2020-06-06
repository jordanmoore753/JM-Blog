module PostsHelper
  def valid_user?(post)
    post.user_id == cookies.encrypted[:user_id] && request.env['PATH_INFO'] == '/profile'
  end
end
