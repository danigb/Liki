class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_space, :current_user_level

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
    def current_space
      Space.first
    end

    def current_user
      begin
        User.find session[:user_id]
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end

  else
    def current_space
      if session[:space_id].blank?
        @current_space = Space.find_by_host request.env['HTTP_HOST']
        if @current_space
          session[:space_id] = @current_space.id
        else
          session[:space_id] ||= 2
        end
      end
      @current_space ||= Space.find session[:space_id]
    end

    def current_user
      @current_user ||= User.find session[:user_id] if session[:user_id].present?
    end
  end
end
