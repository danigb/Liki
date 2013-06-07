require 'test_helper'

describe Access do
  it 'can update view count' do
    node = create(:node)
    a = node.access(create(:user))
    a.view_count.must_equal 0
    a.update_views
    a.view_count.must_equal 1
  end

  it 'can update edit count' do
    node = create(:node)
    a = node.access(create(:user))
    a.edit_count.must_equal 0
    a.update_edits
    a.edit_count.must_equal 1
  end
end
