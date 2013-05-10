class UsersController < ApplicationController
  respond_to :html
  before_filter :require_owner_or_admin

  def show
    @member = current_space.member(user)
    respond_with user
  end

  def edit
    respond_with user
  end

  def new
    @user = User.new
    respond_with @user
  end

  def update
    user.attributes = user_params
    user.save
    respond_with user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Member.create(space: current_space, user: @user)
    end
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
    unless current_user && (current_user.admin? || current_user == user)
      member = current_space.member(current_user)
      redirect_to member ? member.node : root_path
    end
  end
end
