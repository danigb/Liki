class NodesController < ApplicationController
  before_filter :require_user
  respond_to :html

  def search
    @query = params[:q] if params[:q].present? && params[:q].length > 2
    nodes = current_group.nodes
    @query.present? ? 
      @nodes = nodes.where(Node.arel_table[:title].matches("%#{@query}%")) :
      @nodes = nodes.where('1 = 0')
  end

  def index
    @nodes = current_group.nodes.reorder('updated_at DESC').limit(20)
  end

  def show
    if params[:id] =~ /^\d+$/
      @node = Node.find(params[:id])
      @node.parent ? redirect_to(@node.parent) : 
        respond_with(@node)
    elsif @node = Node.find_by_slug(params[:id])
      respond_with @node
    else
      @title = params[:id].camelcase.gsub /-/, ' '
      @node = Node.new(title: @title)
      render action: 'new'
    end
  end

  def edit
    respond_with node
  end

  def create
    @node = Node.new
    @node.attributes = node_params
    @node.group = current_group
    @node.user = current_user
    @node.save
    respond_with @node
  end

  def update
    node.attributes = node_params
    node.save
    NodeService.reorder_children(node) if params[:reorder]
    NodeService.update_mentions(node)
    MentionWorker.perform_async
    respond_with @node
  end

  def destroy
    node.destroy
    redirect_to node.parent ? node.parent : root_path
  end

  def up 
    node.move_higher
    redirect_to node.parent
  end 

  def down
    node.move_lower
    redirect_to node.parent
  end

  def add_children
    @parent = current_group.nodes.find(params[:parent_id])
    NodeService.add_children(params[:text], @parent, current_user)
    redirect_to @parent
  end

  private
  def node
    @node ||= current_group.nodes.find(params[:id])
  end

  def node_params
    params.require(:node).permit(:title, :link_url, 
                                 :body, :image,
                                 :parent_id)
  end
end
