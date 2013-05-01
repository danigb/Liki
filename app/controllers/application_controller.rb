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

  def current_user=(id)
    @current_user = nil
    session[:user_id] = id
  end

  if Rails.env.test?
    def current_group
      Group.first
    end

    def current_user
      begin
        User.find session[:user_id]
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end

  else
    def current_group
      session[:group_id] ||= 2
      @current_group ||= Group.find session[:group_id]
    end

    def current_user
      @current_user ||= User.find session[:user_id] if session[:user_id].present?
    end
  end

end
