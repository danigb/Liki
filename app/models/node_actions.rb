class NodeActions
  attr_reader :current_user, :current_space

  def initialize(current_user, current_space)
    @current_user = current_user
    @current_space = current_space
  end

  def create_node(node_params)
    node = Node.new
    node.attributes = node_params
    node.space = @current_space
    node.user = @current_user
    node.save
    Following.follow(node, @current_user)
    Notifier.perform_async(:create, 'Node', @current_user.id, node.id)
    node
  end

  def update_node(node, node_params, admin_params)
    node.attributes = node_params
    node.save
    node.mentioner.update_mentions
    admin_update_node(node, admin_params) if @current_user.admin?
    Notifier.perform_async(:update, 'Node', @current_user.id, node.id)
    MentionWorker.perform_async
    node
  end

  def admin_update_node(node, admin)
    remove_slug(node) if admin[:remove_slug].present?
    node.admin.reorder_children if admin[:reorder].present?
    node.admin.move_to(admin[:move_to_parent_id]) if admin[:move_to_parent_id].present?
    change_owner(node, admin[:change_owner]) if admin[:change_owner].present?
    node.admin.reorder_alphabetically if admin[:reorder_alphabetically].present?
  end

  def remove_slug(node)
    node.update_attributes(slug: nil)
  end

  def change_owner(node, owner_id)
    user = User.find(owner_id.parameterize)
    node.update_attributes(user_id: user.id)
    Following.follow(node, user)
  end

end
