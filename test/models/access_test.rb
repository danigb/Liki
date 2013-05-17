require 'test_helper'

describe Access do
  it 'can get access for a node' do
    node = create(:node)
    user = create(:user)

    a = Access.get(node, user)
    a.must_be :present?
    Access.get(node, user).must_equal a
  end

  it 'can update view count' do
    a = Access.get(create(:node), create(:user))
    a.view_count.must_equal 0
    a.view!
    a.view_count.must_equal 1
  end
end
