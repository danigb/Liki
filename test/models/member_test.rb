require 'test_helper'

describe Member do
  it 'has auth_token' do
    user = create(:user)
    group = create(:group)

    m = Member.create(user: user, group: group)
    m.auth_token.must_be :present?
    m.auth_token_created_at.must_be :present?
  end

  it 'same group can not have same user twice' do
    group = create(:group)
    user = create(:user)

    Member.create!(user: user, group: group)
    m = Member.create(user: user, group: group)
    m.save.must_equal false
  end

  it 'members have nodes' do
    g = create(:group)
    u = create(:user)
    m = Member.create(user: u, group: g)
    m.node.must_be :present?
  end
end
