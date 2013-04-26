require 'test_helper'

describe Group do
  it "has name" do
    group = create(:group)
    group.name.must_be :present?
  end

  it "has members and users" do
    group = create(:group)
    u1 = create(:user)
    u2 = create(:user)

    Member.create(group: group, user: u1)
    Member.create(group: group, user: u2)

    group.members.count.must_equal 2
    group.users.must_include u1
    group.users.must_include u2
    group.reload
    group.members_count.must_equal 2
  end
end

