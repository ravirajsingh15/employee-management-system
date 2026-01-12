class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :curret_user, :logged_in?

  def curret_user
    @curret_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    redirect_to login_path unless curret_user
  end

  def logged_in?
    curret_user.present?
  end

end
