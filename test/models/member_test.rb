require 'test_helper'

describe Member do
  it 'has auth_token' do
    user = create(:user)
    space = create(:space)

    m = Member.create(user: user, space: space)
    m.auth_token.must_be :present?
    m.auth_token_created_at.must_be :present?
  end

  it 'same space can not have same user twice' do
    space = create(:space)
    user = create(:user)

    Member.create!(user: user, space: space)
    m = Member.create(user: user, space: space)
    m.save.must_equal false
  end

  it 'members have nodes' do
    g = create(:space)
    u = create(:user)
    m = Member.create(user: u, space: g)
    m.node_id.must_be :present?
  end
end
