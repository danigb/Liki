class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include HasCurrentUser
  include HasCurrentSpace

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.blank?
      redirect_to login_path(from: request.path), 
        alert: 'Tienes que identificarte antes de continuar'
    else
      redirect_to access_denied_path(from: request.path)
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, current_space)
  end
end
