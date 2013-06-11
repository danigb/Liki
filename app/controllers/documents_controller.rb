class DocumentsController < ApplicationController
  respond_to :html

  def show
    respond_with node
  end

  protected
  def node
    @node ||= current_space.nodes.find params[:node_id]
  end
end
