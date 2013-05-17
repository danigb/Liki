require 'test_helper'

describe AccessAdminActions do
  it 'can add editor by user name' do
    node = create(:node)
    user = create(:user, name: 'a user')
    actions = AccessAdminActions.new(node.space, create(:user))
    actions.node = node
    actions.add_editor_user_name = 'a user'
    node.accesses.count.must_equal 1
    Access.get(node, user).edit_level.must_equal Access::EDITOR
  end
end
