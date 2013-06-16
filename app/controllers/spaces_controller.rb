class SpacesController < ApplicationController
  respond_to :html
  before_filter :require_admin

  def index
    @spaces = Space.order('name ASC')
    respond_with @spaces
  end

  def new
    @space = Space.new
    respond_with @space
  end

  def edit
    respond_with space
  end

  def create
    @space = Space.new(space_params)
    @space.user = current_user
    @space.save
    @space.member(current_user)
    respond_with @space, location: spaces_path
  end

  def update
    space.attributes = space_params
    space.save
    service.regenerate_counters if params[:regenerate_counters].present?
    service.regenerate_mentions if params[:regenerate_mentions].present?
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
    params.require(:space).permit(
      :name, :host, :email, 
      :photos_node_id,
      :is_open, :background_image,
      :has_wiki, :has_calendar, :has_photos, :has_map)
  end

  def service
    @service ||= SpaceService.new(current_space)
  end

end
