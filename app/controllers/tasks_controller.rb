class TasksController < ApplicationController
  respond_to :html

  def show
    respond_with node
  end

  protected
  def node
    @node ||= Node.find params[:node_id]
  end
end
