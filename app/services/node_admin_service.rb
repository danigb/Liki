class NodeAdminService
  attr_reader :node
  def initialize(node)
    @node = node
    @space = node.space
  end

  def move_to_parent(parent)
    return unless parent.present?
    before_parent = node.parent
    new_parent_id = parent == '-1' ? nil : 
      @space.nodes.find(parent.parameterize).id
    @node.attributes = { parent_id: new_parent_id, position: 10000 }
    @node.save
    reorder_children_of(before_parent) if before_parent
    reorder_children_of(@node.parent) if @node.parent
  end

  def add_node_editor(user_name)
    user = User.where(slug: user_name.parameterize).first
    return unless node && user
    if access = node.access(user)
      access.update_attributes(edit_level: Access::EDITOR)
    end
    access
  end

  protected
  def reorder_children_of(node)
    node.children.each_with_index do |n, i|
      n.update_columns(position: i + 1)
    end
  end
end
