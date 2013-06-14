class PrototypesController < ApplicationController
  respond_to :html
  before_filter :require_admin

  def index
  end

  def show
    respond_with prototype
  end

  def new
    @prototype = Prototype.new
    respond_with @prototype
  end

  def edit
    respond_with prototype
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.space = current_space
    @prototype.save
    respond_with @prototype
  end

  def update
    prototype.attributes = prototype_params
    prototype.save
    respond_with prototype
  end

  def destroy
    prototype.destroy
    respond_with prototype
  end

  protected
  def prototypes
    @prototypes ||= current_space.prototypes
  end
  def prototype
    @prototype ||= prototypes.find params[:id]
  end

  def prototype_params
    params.require(:prototype).permit(
      :name, :body, :order_options, :children_id,
      :photos, :tasks, :comments, :document,
      :show_map, :map_marker, :event)
  end
end
