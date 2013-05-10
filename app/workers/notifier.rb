class Notifier
  include Sidekiq::Worker

  def perform(action, class_name, current_user_id, model_id, options = {})
    @current_user = User.find(current_user_id) if current_user_id.present?

    action = action.to_s.sub(/e?$/, "ed")
    self.send("#{class_name.downcase}_#{action}", model_id, options)
  end

  private
  def node_created(node_id, options)
    node = Node.find(node_id)
    node.space.followers.each do |user|
      NotifyMailer.node_created(user, node).deliver
    end

    if node.parent
      node.parent.followers.each do |user|
        NotifyMailer.children_node_created(user, node).deliver unless user == @current_user
      end
    end
  end

  def node_updated(node_id, options) 
    node = Node.find(node_id)
    node.space.followers.each do |user|
      NotifyMailer.space_follower_node_updated(user, node).deliver
    end
  end
end
