class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_group, :current_user_level

  protected
  def require_user
    if current_user.blank?
      redirect_to login_path
    end
  end

  def current_user=(id)
    @current_user = nil
    session[:user_id] = id
  end

  def current_user_level
    session[:current_user_level] ||= current_user.try(:admin?) ? 0 : 4
    session[:current_user_level]
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
