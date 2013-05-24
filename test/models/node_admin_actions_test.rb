require 'test_helper'

describe NodeAdminActions do
  it 'move item' do
    p1 = create(:node)
    a = create(:node, parent: p1)
    b = create(:node, parent: p1)
    p2 = create(:node, title: 'dos', space: p1.space)
    c = create(:node, parent: p2)
    
    actions = NodeAdminActions.new(a, create(:user))
    actions.move_to_parent = 'dos'

    a.reload
    a.parent.must_equal p2
    a.position.must_equal 2

    b.reload
    b.position.must_equal 1
  end

  it 'changes owner' do
    p1 = create(:node)
    u = create(:user)

    actions = NodeAdminActions.new(p1, create(:user))
    actions.change_owner = u.slug

    p1.reload
    p1.user.must_equal u
  end

  it 'removes slug' do
    node = create(:node, title: 'the title')
    node.slug.must_be :present?
    actions = NodeAdminActions.new(node, create(:user))
    actions.remove_slug = true
    node.reload
    node.slug.must_be :blank?
  end

  it 'can reorder children' do
    p = create(:node)
    a = create(:node, parent: p)
    b = create(:node, parent: p)
    c = create(:node, parent: p)
    c.position.must_equal 3
    b.destroy

    actions = NodeAdminActions.new(p, create(:user))
    actions.reorder_children = true

    c.reload
    c.position.must_equal 2
  end

  it 'reorder alphabetically' do
    p = create(:node)
    b = create(:node, title: 'b', parent: p)
    a = create(:node, title: 'a', parent: p)
    b.position.must_equal 1

    actions = NodeAdminActions.new(p, create(:user))
    actions.reorder_alphabetically = true

    b.reload
    b.position.must_equal 2
  end

end
