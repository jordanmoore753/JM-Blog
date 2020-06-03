module SessionsHelper
  def current_user
    if cookies.encrypted[:user_id]
      user = User.find_by(id: cookies.encrypted[:user_id])
    else
      nil
    end
  end

  def current_user?(user)
    current_user == user
  end

  def remember(user)
    cookies.encrypted[:user_id] = { value: user.id, expires: 4.weeks.from_now }
  end

  def forget
    cookies.delete(:user_id)
  end

  def logged_in?
    !current_user.nil?
  end
end