class AdminNode
  def initialize(node)
    @node = node
  end

  def move_to(parent_id)
    before_parent = @node.parent
    new_parent_id = parent_id == -1 ? nil : Node.find(parent_id).id
    @node.update_attributes(parent_id: new_parent_id, position: 10000)
    before_parent.admin.reorder_children if before_parent
    @node.parent.admin.reorder_children if @node.parent
  end

  def reorder_children
    @node.children.each_with_index do |n,i|
      n.update_columns(position: i + 1)
    end
  end

  def change_owner(owner_id)
    user = User.find(owner_id)
    @node.update_attributes(user_id: user.id)
  end
end
