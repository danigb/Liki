class MembersController < ApplicationController
  before_filter :require_admin

  def index
    @members = current_group.members
  end
  

  protected
  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end
end