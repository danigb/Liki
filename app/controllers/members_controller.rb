class MembersController < ApplicationController
  before_filter :require_admin

  def index
    @members = current_space.members.joins(:user).order('users.email')
    @new_member = current_space.members.build
  end

  def create
    user_id = params[:member][:user_id].parameterize
    user = User.find(user_id)
    current_space.add_member(user)
    redirect_to members_path
  end

  def destroy
    member.destroy
    redirect_to members_path
  end

  protected
  def member
    @member ||= Member.find params[:id]
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end
end
