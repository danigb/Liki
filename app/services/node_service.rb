class NodeService < ApplicationService
  attr_reader :node

  def show(node_id)
    authorize! :read, load_node(node_id)
    node.access(current_user).try(:update_views)
    node.view_count = node.view_count + 1
    node.save
    node
  end

  def edit(node_id)
    authorize! :update, load_node(node_id)
  end

  def new(title, parent_id, proto_id)
    parent = parent_id.blank? ? nil :
      current_space.nodes.find(parent_id.parameterize)
    proto = proto_id.blank? ? current_space.default_prototype :
      current_space.prototypes.find(proto_id)

    @node = Node.new(
      title: title, parent: parent,
      space: current_space, prototype: proto,
      body: proto.body)

    authorize! :create, @node
  end

  def create(node_params)
    @node = Node.new(node_params)
    @node.space = current_space
    @node.user = current_user
    authorize! :create, @node
    save_node
  end

  def update(node_id, node_params)
    authorize! :update, load_node(node_id)
    @node.attributes = node_params
    save_node
  end

  def destroy(node_id)
    authorize! :destroy, load_node(node_id)
    @node.destroy
  end

  protected
  def load_node(node_id)
    @node = current_space.nodes.find(node_id)
  end

  def save_node
    save(@node) do
      update_edits
      update_mentions
      track_activity(node, :create)
    end
  end

  def update_edits
    node.access(current_user).update_edits
    Following.follow(node, current_user)
  end

  def update_mentions
    node.mentioner.update_mentions
    Workers.push(MentionWorker)
  end

  def track_activity(node, action)
    Workers.push(TrackActivityWorker, action.to_s, 'Node', node.id, current_user.id)
    Workers.push(NotifierWorker, action, 'Node', current_user.id, node.id)
  end
end
