module SessionsHelper
  def current_user
    if cookies.encrypted[:user_id]
      user = User.find_by(cookies.encrypted[:user_id])
    else
      nil
    end
  end

  def current_user?(user)
    current_user == user
  end
end