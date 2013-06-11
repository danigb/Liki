class NodePresenter < SimpleDelegator
  attr_reader :node

  def initialize(node, view)
    super(view)
    @node = node
  end

  def render_node
    render @node, node: @node, presenter: self
  end

  def render_photos
    content_tag :div, class: 'photos' do
      render @node.photos
    end
  end

  def render_children
    children = @node.proto.order(@node.children)
    content_tag :div, class: 'children' do
      render partial: 'summary', 
        collection: children, as: :node
    end
  end

  def render_document
    render 'nodes/document', node: node
  end

  def render_mentioned
    if node.mentioned_by_nodes.size > 0
      render 'mentioned', node: node
    end
  end
end
