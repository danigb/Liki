require 'test_helper'

describe Access do
  it 'can update view count' do
    node = create(:node)
    a = node.access(create(:user))
    a.view_count.must_equal 0
    a.view!
    a.view_count.must_equal 1
  end
end
