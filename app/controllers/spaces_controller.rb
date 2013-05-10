class SpacesController < ApplicationController
  respond_to :html
  before_filter :require_user, :require_super

  def index
    @spaces = Space.all
    respond_with @spaces
  end

  def edit
    respond_with space
  end

  def update
    space.attributes = space_params
    space.save
    space.regenerate_counters if params[:regenerate_counters].present?
    space.regenerate_mentions if params[:regenerate_mentions].present?
    respond_with space, location: spaces_path
  end

  def show
    redirect_to current_space.node
  end

  protected
  def space
    @space ||= Space.find params[:id]
  end

  def space_params
    params.require(:space).permit(:name, :host)
  end

  def require_super
    unless current_user.admin?
      redirect_to root_path
    end
  end
end