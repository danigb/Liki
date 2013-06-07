class AccessService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def show(node)
    node.space.is_open? ?
      no_user_required(node) :
      member_required(node)
  end

  def create(node)
    member_required(node)
  end

  def update(node)
    member_required(node)
  end

  protected
  def member_required(node)
    return deny(:user_required) unless user
    node.space.member(user) ?
      node.access(user) :
      deny(:member_required)
  end

  def no_user_required(node)
    user.present? ?
      node.access(user) :
      Access.new(node: node, user: user)
  end

  def deny(cause)
    AccessDenied.new(user, cause)
  end
end
