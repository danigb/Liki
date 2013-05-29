require 'test_helper'

describe Activity do
  it 'creates activity' do
    n = create(:node)
    a = Activity.track(:create, n, create(:user))
    a.must_be :present?
  end

  it 'updates activity date if track again' do
    a = Activity.track(:create, create(:node), create(:user))
    a.updated_at.must_equal a.created_at
    b = Activity.track(:create, a.trackable, a.user)
    b.must_equal a
    b.updated_at.wont_equal b.created_at
  end
end

