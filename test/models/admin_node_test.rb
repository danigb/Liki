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

  it 'move item' do
    p1 = create(:node)
    a = create(:node, parent: p1)
    b = create(:node, parent: p1)
    p2 = create(:node)
    c = create(:node, parent: p2)

    a.admin.move_to(p2)
    b.reload
    b.position.must_equal 1
    a.reload
    a.parent.must_equal p2
    a.position.must_equal 2
  end

end
