class NodesController < ApplicationController
  before_filter :require_user
  respond_to :html

  def root
    @node = current_space.node
    render action: 'show'
  end

  def search
    @query = params[:q] if params[:q].present? && params[:q].length > 2
    nodes = current_space.nodes
    @query.present? ? 
      @nodes = nodes.where(Node.arel_table[:title].matches("%#{@query}%")) :
    @nodes = nodes.where('1 = 0')
  end

  def index
    @nodes = current_space.nodes.reorder('created_at DESC').limit(20)
  end

  def show
    action = NodeShowAction.new(current_space, current_user)
    action.show(params[:id])

    if action.redirect
      redirect_to node_path(action.redirect, action.redirect_params)
    elsif action.node
      respond_with node
    else
      @title = params[:id].camelcase.gsub /-/, ' '
      @node = Node.new(title: @title)
      render action: 'new'
    end
  end

  def admin
    @form = AdminAccessesForm.new(node: node, action: access_action)
    respond_with node
  end

  def new
    @node = Node.new
  end

  def edit
    respond_with node
  end

  def create
    actions = NodeActions.new(current_user, current_space)
    node = actions.create_node(node_params)
    respond_with node, location: node_location(node)
  end

  def update
    if params[:node].present?
      actions = NodeActions.new(current_user, current_space)
      actions.update_node(node, node_params, params)
    end
    if params[:admin].present?
      form = AdminAccessesForm.new(node: node, action: access_action)
      if form.validate(params[:admin])
        access_action.node = node
        form.save
      end
    end
    respond_with node, location: node_location(node)
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

  private
  def node
    @node ||= current_space.nodes.find(params[:id])
  end

  def access_action
    @access_admin_action ||= AccessAdminAction.new(
      current_space, current_user)
  end

  def node_location(node)
    node.parent ? node.parent : node
  end

  def node_params
    params.require(:node).permit(:title, :body, :style,
                                 :document, :image, :slug,
                                 :remove_image, :remove_document,
                                 :parent_id)
  end
end
