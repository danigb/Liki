class AccessService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def view?(node)
    return deny(:user_required) unless user
    node.space.member(user) ?
      node.access(user) :
      deny(:member_required)
  end

  protected
  def deny(cause)
    AccessDenied.new(user, cause)
  end
end
