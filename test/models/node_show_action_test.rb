require 'test_helper'

describe NodeShowAction do
  it 'updates view count' do
    node = create(:node, title: 'uno')
    user = create(:user)

    action = NodeShowAction.new(node.space, node.user)
    action.show(node.slug)
    action.has_better_id?.must_equal false
    action.node.must_equal node

    Access.get(node, user).view_count.must_equal 1
    node.reload
    node.view_count.must_equal 1
  end
end
