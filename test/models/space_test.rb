require 'test_helper'

describe Space do
  it "has name" do
    space = create(:space)
    space.name.must_be :present?
  end

  it 'has node' do
    space = create(:space)
    space.node.must_be :present?
  end

  it "has members and users" do
    space = create(:space)
    u1 = create(:user)
    u2 = create(:user)

    Member.create(space: space, user: u1)
    Member.create(space: space, user: u2)

    space.members.count.must_equal 2
    space.users.must_include u1
    space.users.must_include u2
    space.reload
    space.members_count.must_equal 2
  end

  it 'has followers' do
    g = create(:space)
    u = create(:user)
    f = Following.follow(g, u)
    g.followings.must_include f
    g.followers.must_include u
  end
end

