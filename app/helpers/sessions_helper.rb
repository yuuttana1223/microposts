module SessionsHelper
  def current_user
    # @current_userが既にログインされていたら何もせず、していなかったらセッションから取ってくる
    @current_user ||= User.find_by(id: session[:user_id]) 
  end

  def logged_in?
    # if current_user
    #   return true
    # else
    #   return false
    !!current_user
  end
end
