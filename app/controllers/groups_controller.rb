class GroupsController < ApplicationController
  respond_to :html
  before_filter :require_user, :require_super

  def index
    @groups = Group.all
    respond_with @groups
  end

  def edit
    respond_with group
  end

  def update
    group.attributes = group_params
    group.save
    group.regenerate_counters if params[:regenerate_counters].present?
    group.regenerate_mentions if params[:regenerate_mentions].present?
    respond_with group, location: groups_path
  end

  def show
    redirect_to current_group.node
  end

  protected
  def group
    @group = Group.find params[:id]
  end

  def group_params
    params.require(:group).permit(:name)
  end

  def require_super
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
