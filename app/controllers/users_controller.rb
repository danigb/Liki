class UsersController < ApplicationController
  respond_to :html
  before_filter :require_admin, only: :index

  def index
    @users = User.order('name ASC')
    respond_with @users
  end

  def show
    if current_user == user || current_user.admin
      @followings = user.followings.where(followed_type: 'Node').where(space_id: current_space.id).order('created_at DESC')
      respond_with user
    else
      member = current_space.member(user)
      redirect_to member.node
    end
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
    @member ||= current_space.member(@user)
    @user
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :admin, :slug, :password)
  end
end
