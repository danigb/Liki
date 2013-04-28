class UsersController < ApplicationController
  respond_to :html

  def show
    member = current_group.member(user)
    redirect_to member.node
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
end
