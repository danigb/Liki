class DocumentsController < ApplicationController
  respond_to :html

  def show
    respond_with node
  end

  def destroy
    node.remove_document = true
    node.save
    redirect_to document_node_path(node)
  end

  protected
  def node
    @node ||= current_space.nodes.find params[:node_id]
  end
end
