class NodeAdminActions
  attr_reader :node, :space, :user
  attr_reader :move_to_parent, :change_owner, 
    :remove_slug, :reorder_children,
    :reorder_alphabetically,
    :children_role

  def initialize(node, user)
    @node = node
    @space = node.space
    @user = user
  end

  def move_to_parent=(parent)
    if parent.present?
      before_parent = node.parent
      new_parent_id = parent == -1 ? nil : Node.find(parent).id
      @node.attributes = { parent_id: new_parent_id, position: 10000 }
      @node.save
      reorder_children_of(before_parent) if before_parent
      reorder_children_of(@node.parent) if @node.parent
    end
  end

  def change_owner=(owner)
    if owner.present?
      user = User.find_by_slug(owner.parameterize)
      if user
        @node.user = user
        @node.save
      end
    end
  end

  def remove_slug=(remove_slug)
    if is_true?(remove_slug)
      @node.slug = nil
      @node.save
    end
  end

  def reorder_children=(reorder_children)
    if is_true?(reorder_children)
      reorder_children_of(@node)
    end
  end

  def reorder_alphabetically=(reorder_alphabetically)
    if is_true?(reorder_alphabetically)
      @node.children.reorder('title ASC').each_with_index do |n, i|
        n.update_columns(position: i + 1)
      end
    end
  end

  def children_role=(role)
    if role.present?
      @node.children.each do |c|
        c.update_attributes(role: role)
      end
    end
  end

  protected
  def is_true?(parameter)
    parameter == true || parameter == '1'
  end

  def reorder_children_of(node)
    node.children.each_with_index do |n, i|
      n.update_columns(position: i + 1)
    end
  end
end
