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

  def map
    all = current_group.nodes.where('title IS NOT NULL')
    mentions = Mention.all
    ms = mentions.map do |mention|
      if mention.from.blank? || mention.to.blank?
        mention.destroy
      else
        [mention.from.title, mention.to.title, {color: '#EDC951'}] 
      end
    end
    titles = all.map &:title
    all.each do |node|
      ms << [node.parent.title, node.title, {color: '#CC333F'}] if node.parent
    end
    @data = Jbuilder.encode do |json|
      json.nodes titles
      json.edges ms
    end
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

  def new
    @node = Node.new
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
    if current_user.admin?
      node.admin.reorder_children(node) if params[:reorder].present?
      node.admin.move_to(params[:move_to_parent_id]) if params[:move_to_parent_id].present?
      node.admin.change_owner(params[:change_owner]) if params[:change_owner].present?
      node.admin.reorder_alphabetically if params[:reorder_alphabetically].present?
    end
    node.mentioner.update_mentions
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

  private
  def node
    @node ||= current_group.nodes.find(params[:id])
  end

  def node_params
    params.require(:node).permit(:title, :body, :style,
                                 :document, :image, :subtitle,
                                 :remove_image, :remove_document,
                                 :parent_id)
  end
end
