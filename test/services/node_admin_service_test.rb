require 'test_helper'

describe NodeAdminService do
  let(:node) { create(:node) }
  let(:service) { NodeAdminService.new(node) }

  it 'add user name as editor' do
    user = create(:user)
    service.add_node_editor(user.name)
    node.access(user).edit_level.must_equal Access::EDITOR
  end
end
