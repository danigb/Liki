class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include HasCurrentUser
  include HasCurrentSpace

  rescue_from AccessDenied do |exception|
    if current_user.blank?
      redirect_to login_path(from: request.path), 
        alert: 'Tienes que identificarte antes de continuar'
    else
      redirect_to access_denied_path(from: request.path)
    end
  end

end
