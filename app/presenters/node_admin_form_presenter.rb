class NodeAdminFormPresenter < FormPresenter
  attr_accessor :node_id
  attr_accessor :move_to_parent
  attr_accessor :change_owner
  attr_accessor :remove_slug
  attr_accessor :reorder_children
  attr_accessor :reorder_alphabetically
  attr_accessor :children_role

  def save
    service.move_to_parent(move_to_parent)
  end

  protected
  def node
    @node ||= Node.find(node_id)
  end

  def service
    @service ||= NodeAdminService.new(node)
  end
end
