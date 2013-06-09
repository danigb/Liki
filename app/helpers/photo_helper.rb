module PhotoHelper
  def photos?(node)
    return unless node.present?
    current_space.photos_node_id == node.id
  end

end
