require 'test_helper'

class HasActivityTest < ActiveSupport::TestCase
  it 'has activity' do
    node = create(:node)
    Activity.track(:create, node, node.user)
    node.activities.count.must_equal 1
  end

  it 'deletes activity on destroy' do
    node = create(:node)
    Activity.track(:create, node, node.user)
    node.destroy
    Activity.count.must_equal 0
  end
end
