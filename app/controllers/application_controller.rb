class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :load_current

  protected
  def load_current
    @current_group = Group.first
    @current_user = User.first
  end
end
