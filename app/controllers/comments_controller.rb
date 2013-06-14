class CommentsController < ApplicationController
  respond_to :html
  before_filter :require_user

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.space = current_space
    @comment.node = node
    flash.notice = 'Gracias por comentar.' if @comment.save
    respond_with @comment, location: node
  end

  protected
  def node
    if params[:node_id].present?
      @node ||= current_space.nodes.find params[:node_id]
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
