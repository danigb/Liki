class AccessAdminActions
  attr_accessor :add_editor_user_name

  def initialize(node, user)
    @node = node
    @user = user
  end

  def add_editor_user_name=(user_name)
    user = User.where(slug: user_name.parameterize).first
    access = Access.get(@node, user)
    access.update_attributes(edit_level: Access::EDITOR) if access
  end
end
