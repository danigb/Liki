class MapsController < ApplicationController
  respond_to :html
  before_filter :require_user

  def show
    @map_data = node.to_gmaps4rails
    respond_with node
  end

  def update
    node.attributes = node_params
    flash.notice = 'Mapa guardado' if node.save
    redirect_to node_map_path(node)
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
