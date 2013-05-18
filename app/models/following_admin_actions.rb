class FollowingAdminActions
  attr_reader :add_follower_user_name

  def initialize(node, user)
    @node = node
    @user = user
  end

  def add_follower_user_name=(user_name)
    if user_name.present?
      user = User.where(slug: user_name.parameterize).first
      Following.follow(@node, user)
    end
  end

end
