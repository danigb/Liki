class CommentsController < ApplicationController
  respond_to :html
  before_filter :require_user

  def edit
    service.edit(params[:id])
    respond_with @comment = service.comment
  end

  def create
    service.create(comment_params)
    flash.notice = 'Gracias por comentar.' if service.succeed?
    respond_with @comment = service.comment, location: service.node
  end

  def update
    service.update(params[:id], comment_params)
    flash.notice = 'Comentario modificado.' if service.succeed?
    respond_with service.comment, location: service.node
  end

  def destroy
    service.destroy(params[:id])
    redirect_to service.node, notice: 'Comentario borrado.'
  end

  protected
  def comment_params
    params.require(:comment).permit(:body)
  end

  def service
    @service ||= CommentService.new(current_user, current_space,
                                    params[:node_id])
  end
end
