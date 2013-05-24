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
    @root = current_space.node
  end

  def show
    repo = NodeRepo.new(current_user, current_space)

    if params[:id] =~ /^\d+$/
      redirect_to node_path(node.parent, anchor: node.id)
    elsif @current_space.nodes.find_by_slug(params[:id])
      repo.show(node)
      respond_with node
    else
      @title = params[:id].camelcase.gsub /-/, ' '
      @node = Node.new(title: @title)
      render action: 'new'
    end
  end

  def admin
    access_admin_form
    following_admin_form
    node_admin_form
    respond_with node
  end


  def new
    @node = Node.new
  end

  def edit
    respond_with node
  end

  def create
    repo = NodeRepo.new(current_user, current_space)
    node = Node.new(node_params)
    node = repo.create(node, {dropbox: params['selected-file']})
    respond_with node, location: node_location(node)
  end

  def update
    if params[:node].present?
      repo = NodeRepo.new(current_user, current_space)
      node.attributes = node_params
      repo.update(node, {dropbox: params['selected-file']})
    end
    if node_admin_form.validate(params[:node_admin])
      node_admin_form.save
      node.save
    end
    if access_admin_form.validate(params[:access_admin])
      access_admin_form.save 
    end
    if following_admin_form.validate(params[:following_admin])
      following_admin_form.save
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
    @following_admin_actions ||= FollowingAdminActions.new(
      node, current_user)
    @following_admin_form ||= FollowingAdminForm.new(
      node: node, action: @following_admin_actions)
  end

  def node_location(node)
    node_path(node)
  end

  def node_params
    params.require(:node).permit(:title, :body, 
                                 :document, :image, :slug,
                                 :role, :style, :image_style,
                                 :remove_image, :remove_document,
                                 :parent_id, :prevent_slug_creation)
  end
end
