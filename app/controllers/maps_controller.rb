class MapsController < ApplicationController
  respond_to :html
  before_filter :require_user

  def index
    @nodes = current_space.nodes.
      where("map_address <> ''")
    @map_options = { 
      detect_location: true, center_on_user: true, zoom: 4, type: 'HYBRID'}
    @map_data = @nodes.to_gmaps4rails do |node, marker|
      marker.infowindow render_to_string(
        partial: "/nodes/summary", locals: { node: node })
      marker.title node.title
      marker.json(id: node.id)
    end
  end

  def show
    authorize! :read, node
    @map_options = { 
      detect_location: true, center_on_user: true, zoom: 7, auto_zoom: false, type: 'HYBRID'}
    @map_data = node.to_gmaps4rails
    respond_with node
  end

  def update
    authorize! :update, node
    service.update(node, node_params)
    flash.notice = 'Mapa guardado' if service.succeed?
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

  def service
    @service ||= MapService.new(current_user, current_space)
  end
end
