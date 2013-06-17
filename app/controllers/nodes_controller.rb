class NodesController < ApplicationController
  before_filter :require_user, except: [:root, :show]
  respond_to :html

  def root
    service.show(current_space.node_id)
    @node = service.node
    render action: 'show'
  end

  def index
    @root = current_space.node
  end

  def show
    begin
      service.show(params[:id])
      respond_with @node = service.node
    rescue ActiveRecord::RecordNotFound
      title = params[:id].camelcase.gsub(/-/, ' ')
      redirect_to new_node_path(t: title, p: params[:p])
    end
  end


  def new
    parent_id = params[:node_id] || params[:p]
    @node = service.new(params[:t], parent_id, params[:proto])
    respond_with @node = service.node
  end

  def edit
    service.edit(params[:id])
    respond_with @node = service.node
  end

  def create
    service.create(node_params)
    respond_with @node = service.node
  end

  def update
    service.update(params[:id], node_params)
    respond_with @node = service.node
  end

  def destroy
    service.destroy(params[:id])
    redirect_to (service.node.try(:parent) || root_path)
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
      :parent_id, :title, :body, :prototype_id, :image_url, :document,
      :email, :telephone, :map_address, :url)
  end
end
