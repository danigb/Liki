class NotifierWorker
  include Sidekiq::Worker

  attr_reader :current_user

  def perform(action, class_name, current_user_id, 
              model_id, options = {})

  @current_user = User.find(current_user_id) if current_user_id.present?

  action = action.to_s.sub(/e?$/, "ed")
  self.send("#{class_name.downcase}_#{action}", model_id, options)
  end

  private
  def node_created(node_id, options)
    node = find_node(node_id)
    if node 
      node.space.followers.each do |user|
        NotifyMailer.space_follower_node_created(user, node).deliver
      end

      if node.parent
        node.parent.followers.each do |user|
          NotifyMailer.children_node_created(user, node).deliver unless user == current_user
        end
      end
    end
  end

  def node_updated(node_id, options) 
    node = find_node(node_id)
    if node
      node.space.followers.each do |user|
        NotifyMailer.space_follower_node_updated(user, node).deliver
      end
    end
  end

  def find_node(node_id)
    Node.where(id: node_id).first
  end

end
