class NodeService
  attr_reader :current_user, :current_space

  def initialize(current_user, current_space)
    @current_user = current_user
    @current_space = current_space
  end

  def show(node)
    Access.get(node, current_user).view!
    node.view_count = node.view_count + 1
    node.save
  end

  def create(node, options = {})
    apply_options(node, options)
    node.space = current_space
    node.user = current_user
    node.save!
    launch_workers(node, :create)
    node
  end

  def update(node, options = {})
    apply_options(node, options)
    node.save
    node.mentioner.update_mentions
    launch_workers(node, :update)
    node
  end

  protected
  def launch_workers(node, action)
    Following.follow(node, current_user)
    Workers.push(TrackActivityWorker, action.to_s, 'Node', node.id, current_user.id)
    Workers.push(MentionWorker)
    Workers.push(NotifierWorker, action, 'Node', current_user.id, node.id)
    Workers.push(UploadWorker, node.id)
  end

  def apply_options(node, options)
    node.dropbox_image_url = options[:dropbox] if options[:dropbox].present?
  end

end