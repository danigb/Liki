class NodesController < ApplicationController
  before_filter :require_user, except: [:root, :show]
  respond_to :html

  def root
    @node = current_space.node
    authorize! :read, node
    service.show(@node)
    render action: 'show'
  end

  def index
    @root = current_space.node
  end

  def show
    begin
      authorize! :read, node
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
    @node = Node.new(
      title: params[:t], parent: parent, 
      space: current_space)
    authorize! :create, @node
  end

  def edit
    authorize! :update, node
    respond_with node
  end

  def create
    @node = Node.new(node_params)
    @node.space = current_space
    authorize! :create, @node
    @node = service.create(node, {dropbox: params['selected-file']})
    respond_with @node
  end

  def update
    authorize! :update, node
    node.attributes = node_params
    service.update(node, {dropbox: params['selected-file']})
    respond_with node
  end

  def destroy
    authorize! :destroy, node
    node.destroy
    redirect_to node.parent ? node.parent : root_path
  end

  def up 
    authorize! :update, node
    node.move_higher
    redirect_to node.parent
  end 

  def down
    authorize! :update, node
    node.move_lower
    redirect_to node.parent
  end

  private
  def node
    @node ||= current_space.nodes.find(params[:id])
  end

  def service
    @service ||= NodeService.new(current_user, current_space)
  end

  def node_params
    params.require(:node).permit(
      :title, :body, :parent_id,
      :has_children, :has_photos, :children_name,
      :document, :image_url, :slug,
      :role, :style, :image_style,
      :remove_image, :remove_document,
      :parent_id, :prevent_slug_creation)
  end
end
