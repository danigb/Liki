class MapService < ApplicationService
  def update(node, node_params)
    #create = node.map_address.blank?
    node.attributes = node_params
    @succeed = node.save
  end
end
