require 'test_helper'

describe AdminNode do
  it 'reorder_children' do
    p = create(:node)
    a = create(:node, parent: p)
    b = create(:node, parent: p)
    c = create(:node, parent: p)
    c.position.must_equal 3
  end

end
