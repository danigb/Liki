class NodesController < ApplicationController
  before_filter :require_user
  respond_to :html

  def index
    redirect_to current_group.node
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
    load_node
    respond_with @node
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
    load_node
    @node.attributes = node_params
    @node.save
    respond_with @node
  end

  def destroy
    load_node
    @node.destroy
    redirect_to @node.parent ? @node.parent : root_path
  end

  def add_children
    @parent = current_group.nodes.find(params[:parent_id])
    NodeService.add_children(params[:text], @parent, current_user)
    redirect_to @parent
  end

  private
  def load_node
    @node = current_group.nodes.find(params[:id])
  end

  def node_params
    params.require(:node).permit(:title, :link_url, :body, :image)
  end
end
