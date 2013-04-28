class UsersController < ApplicationController
  respond_to :html
  before_filter :require_owner_or_admin

  def show
    @member = current_group.member(user)
    respond_with user
  end

  def edit
    respond_with user
  end

  def update
    user.attributes = user_params
    user.save
    respond_with user
  end

  protected
  def user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end

  def require_owner_or_admin
    unless current_user.admin? || current_user == user
      member = current_group.member(user)
      redirect_to member ? member.node : root_path
    end
  end
end
