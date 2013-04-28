class NodesController < ApplicationController
  before_filter :require_user
  respond_to :html

  def index
    @nodes = current_group.nodes.reorder('updated_at DESC').limit(20)
  end

  def show
    @node = Node.find_by_slug(params[:id])
    if @node
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
    node.children.each_with_index do |n,i|
      n.update_columns(position: i + 1)
    end
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
    params.require(:node).permit(:title, :link_url, :body, :image,
                                 :parent_id)
  end
end
