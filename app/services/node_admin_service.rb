class NodeAdminService
  attr_reader :node
  def initialize(node)
    @node = node
  end

  def add_node_editor(user_name)
    user = User.where(slug: user_name.parameterize).first
    return unless node && user
    if access = node.access(user)
      access.update_attributes(edit_level: Access::EDITOR)
    end
    access
  end
end
