class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_group

  protected
  def require_user
    if session[:user_id].blank?
      redirect_to login_path
    end
  end

  def current_group
    @current_group ||= Group.first
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end
end
