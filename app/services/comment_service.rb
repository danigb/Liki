class CommentService < ApplicationService
  attr_accessor :comment, :node
  
  def initialize(user, space, node_id)
    super(user, space)
    @node = space.nodes.find(node_id)
  end

  def edit(comment_id)
    load_comment(comment_id)
    authorize! :update, @comment
  end

  def create(comment_params)
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.space = current_space
    @comment.node = node
    save(@comment) 
  end

  def update(comment_id, comment_params)
    load_comment(comment_id)
    authorize! :update, comment
    @comment.attributes = comment_params
    save(@comment)
  end

  def destroy(comment_id)
    load_comment(comment_id)
    @succeed = @comment.destroy
  end

  protected
  def load_comment(id)
    @comment = node.comments.find(id)
  end
end
