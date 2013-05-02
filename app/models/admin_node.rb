class AdminNode
  def initialize(node)
    @node = node
  end

  def self.move_to(parent_id)
    parent_id = nil if parent_id == -1
    @node.update_attributes(parent_id: parent_id)
  end

  def self.reorder_children
    @node.children.each_with_index do |n,i|
      n.update_columns(position: i + 1)
    end
  end

end
