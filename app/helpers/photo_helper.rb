module PhotoHelper
  def photos?(node)
    return unless node.present?
    current_space.photos_node_id == node.id
  end

  def photo_nodes(photo)
    raw(photo.nodes.where("nodes.id <> ?", current_space.photos_node_id).
      map {|n| link_to(arrow(n.title), n)}.join(', '))
  end

end
