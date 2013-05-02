class AdminNode
  def initialize(node)
    @node = node
  end

  def move_to(parent)
    before_parent = @node.parent
    new_parent_id = parent ? parent.id : nil
    @node.update_attributes(parent_id: new_parent_id, position: 10000)
    before_parent.admin.reorder_children if before_parent
    parent.admin.reorder_children if parent
  end

  def reorder_children
    @node.children.each_with_index do |n,i|
      n.update_columns(position: i + 1)
    end
  end

end
