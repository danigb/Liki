class NodeRepo
  attr_reader :current_user, :current_space

  def initialize(current_user, current_space)
    @current_user = current_user
    @current_space = current_space
  end

  def create(node, options = {})
    apply_options(node, options)
    node.space = @current_space
    node.user = @current_user
    node.save
    launch_workers(node)
    node
  end

  def update(node, options = {})
    apply_options(node, options)
    node.save
    node.mentioner.update_mentions
    launch_workers(node)
    node
  end

  protected
  def launch_workers(node)
    Following.follow(node, @current_user)
    Notifier.perform_async(:update, 'Node', @current_user.id, node.id)
    UploadWorker.perform_async(node.id)
    MentionWorker.perform_async
  end

  def apply_options(node, options)
    node.dropbox_image_url = options[:dropbox] if options[:dropbox].present?
  end

end
