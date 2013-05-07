require 'test_helper'

describe Group do
  it "has name" do
    group = create(:group)
    group.name.must_be :present?
  end

  it 'has node' do
    group = create(:group)
    group.node.must_be :present?
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

  it 'has followers' do
    g = create(:group)
    u = create(:user)
    f = Following.follow(g, u)
    g.followings.must_include f
    g.followers.must_include u
  end
end

