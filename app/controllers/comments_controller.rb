class CommentsController < ApplicationController
  respond_to :html
  before_filter :require_user

  def edit
    authorize! :update, node
    respond_with comment
  end

  def create
    authorize! :update, node
    service.create(node, comment_params)
    flash.notice = 'Gracias por comentar.' if service.succeed?
    respond_with service.comment, location: node
  end

  def destroy
    authorize! :destroy, comment
    service.destroy(comment)
    redirect_to node, notice: 'Comentario borrado.'
  end

  protected
  def node
    @node ||= current_space.nodes.find params[:node_id]
  end

  def comment
    @comment ||= node.comments.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def service
    @service ||= CommentService.new(current_user, current_space)
  end
end
