require 'test_helper'

describe AdminNode do
  it 'reorder_children' do
    p = create(:node)
    a = create(:node, parent: p)
    b = create(:node, parent: p)
    c = create(:node, parent: p)
    c.position.must_equal 3
    b.destroy
    p.admin.reorder_children
    c.reload
    c.position.must_equal 2
  end

  it 'reorder alphabetically' do
    p = create(:node)
    b = create(:node, title: 'b', parent: p)
    a = create(:node, title: 'a', parent: p)
    b.position.must_equal 1
    p.admin.reorder_alphabetically
    b.reload
    b.position.must_equal 2
  end

  it 'move item' do
    p1 = create(:node)
    a = create(:node, parent: p1)
    b = create(:node, parent: p1)
    p2 = create(:node, title: 'dos')
    c = create(:node, parent: p2)

    a.admin.move_to('dos')
    b.reload
    b.position.must_equal 1
    a.reload
    a.parent.must_equal p2
    a.position.must_equal 2
  end

  it 'changes owner' do
    p1 = create(:node)
    u = create(:user)

    p1.admin.change_owner(u.slug)
    p1.reload
    p1.user.must_equal u
  end
end
