class NotifierWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  attr_reader :current_user

  def perform(action, class_name, current_user_id, 
              model_id, options = {})

    @current_user = User.find(current_user_id)

    action = action.to_s.sub(/e?$/, "ed")
    method_name = "#{class_name.underscore}_#{action}"
    self.send(method_name, model_id, options) if self.respond_to?(method_name)
  end

  protected
  def photo_tag_created(photo_tag_id, options)
    if tag = PhotoTag.where(id: photo_tag_id).first
      tag.node.followers.each do |user|
        unless user == current_user
          NotifyMailer.photo_tag_created(user, tag)
        end
      end
    end
  end

  def node_created(node_id, options)
    node = find_node(node_id)
    if node 
      node.space.followers.each do |user|
        NotifyMailer.space_follower_node_created(user, node).deliver unless user == current_user
      end

      if node.parent
        node.parent.followers.each do |user|
          NotifyMailer.children_node_created(user, node).deliver unless user == current_user
        end
      end
    end
  end

  def no_node_updated(node_id, options) 
    node = find_node(node_id)
    if node
      node.space.followers.each do |user|
        NotifyMailer.space_follower_node_updated(user, node).deliver unless user == current_user
      end
    end
  end

  def find_node(node_id)
    Node.where(id: node_id).first
  end

end
