module HasCurrentUser
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :current_user_level
  end

  protected
  def require_user
    if current_user.blank?
      redirect_to login_path(from: request.path), 
        alert: 'Tienes que identificarte para continuar'
    end
  end

  def current_user=(id)
    @current_user = nil
    session[:current_user_level] = nil
    session[:user_id] = id
  end

  def current_user_level
    session[:current_user_level] ||= current_user.try(:admin?) ? 0 : 4
    session[:current_user_level]
  end
  if Rails.env.test?
    def current_user
      begin
        User.find session[:user_id]
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end
  else
    def current_user
      @current_user ||= User.find session[:user_id] if session[:user_id].present?
    end
  end
end
