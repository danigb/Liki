class CommentService
  attr_accessor :current_user, :current_space
  attr_accessor :comment

  def initialize(user, space)
    @current_user = user
    @current_space = space
  end

  def create(node, comment_params)
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.space = current_space
    @comment.node = node
    @succeed = @comment.save
  end

  def destroy(comment)
    @succeed = comment.destroy
  end

  def succeed?
    @succeed
  end
end
