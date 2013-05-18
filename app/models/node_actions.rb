class NodeActions
  attr_reader :current_user, :current_space

  def initialize(current_user, current_space)
    @current_user = current_user
    @current_space = current_space
  end

  def create_node(node_params, options = {})
    node = Node.new
    node.attributes = node_params
    node.remote_image_url = options[:dropbox] if options[:dropbox]
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
    Notifier.perform_async(:update, 'Node', @current_user.id, node.id)
    MentionWorker.perform_async
    node
  end

  def add_tag(node, tag_name)
    return if tag_name.blank?
    tag = Node.find(tag_name.parameterize)
    Tagging.create(tag: tag, tagged: node) if tag
  end
end
