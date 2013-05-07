class Actions
  def initialize(current_user, current_group)
    @current_user = current_user
    @current_group = current_group
  end

  def create_node(node_params)
    node = Node.new
    node.attributes = node_params
    node.group = @current_group
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
    if @current_user.admin?
      node.admin.reorder_children(node) if admin_params[:reorder].present?
      node.admin.move_to(params[:move_to_parent_id]) if admin_params[:move_to_parent_id].present?
      node.admin.change_owner(params[:change_owner]) if admin_params[:change_owner].present?
      node.admin.reorder_alphabetically if admin_params[:reorder_alphabetically].present?
    end
    Notifier.perform_async(:update, 'Node', @current_user.id, node.id)
    MentionWorker.perform_async
    node
  end

end
