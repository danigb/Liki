class MapsController < ApplicationController
  respond_to :html
  before_filter :require_user

  def index
    @nodes = current_space.nodes.
      where("map_address <> ''")
    @map_data = @nodes.to_gmaps4rails
  end

  def show
    @map_data = node.to_gmaps4rails
    respond_with node
  end

  def update
    node.attributes = node_params
    flash.notice = 'Mapa guardado' if node.save
    respond_with node
  end

  protected
  def node
    @node ||= current_space.nodes.find params[:node_id]
  end

  def node_params
    params.require(:node).permit(
      :latitude, :longitude, :map_address)
  end
end
