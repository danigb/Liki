class NodesController < ApplicationController

  def index
    redirect_to @current_group.node
  end

  def show
    @node = @current_group.nodes.find(params[:id])
  end
end
