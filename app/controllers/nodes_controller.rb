class NodesController < ApplicationController
  before_filter :require_user, except: [:root, :show]
  respond_to :html

  def root
    @node = current_space.node
    service.show(@node)
    render action: 'show'
  end

  def index
    @root = current_space.node
  end

  def show
    begin
      service.show(node)
      respond_with node
    rescue ActiveRecord::RecordNotFound
      title = params[:id].camelcase.gsub(/-/, ' ')
      redirect_to new_node_path(t: title, p: params[:p])
    end
  end

  def admin
    @access_form = AccessFormPresenter.new
    @node_admin_form = NodeAdminFormPresenter.new(node_id: node.id)
    @following_form = FollowingFormPresenter.new
    if request.request_method_symbol == :post
    NodeAdminFormPresenter.new(params[:node_admin_form_presenter]).save
    end
    respond_with node
  end


  def new
    parent = current_space.nodes.find(params[:p].parameterize) if params[:p].present?
    @node = Node.new(title: params[:t], parent: parent)
  end

  def edit
    respond_with node
  end

  def create
    @node = Node.new(node_params)
    @node = service.create(node, {dropbox: params['selected-file']})
    respond_with @node
  end

  def update
    node.attributes = node_params
    service.update(node, {dropbox: params['selected-file']})
    respond_with node
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

  def access_admin_form
    @access_admin_actions ||= AccessAdminActions.new(
      node, current_user)
    @access_admin_form ||= AccessAdminForm.new(
      node: node, action: @access_admin_actions)
  end

  def node_admin_form
    @node_admin_actions ||= NodeAdminActions.new(node, current_user)
    @node_admin_form ||= NodeAdminForm.new(
      node: node, action: @node_admin_actions)
  end

  def following_admin_form
    @following_admin_form ||= FollowingFormPresenter.new(node_id: node.id)
  end

  def service
    @service ||= NodeService.new(current_user, current_space)
  end

  def node_params
    params.require(:node).permit(
      :title, :body, :parent_id,
      :has_children, :has_photos, :children_name,
      :document, :image, :slug,
      :role, :style, :image_style,
      :remove_image, :remove_document,
      :parent_id, :prevent_slug_creation)
  end
end
