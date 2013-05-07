require 'test_helper'

describe Following do
  it 'find following' do
    user = create(:user)
    node = create(:node)
    f = Following.create(user_id: user.id, followed_id: node.id,
                         followed_type: 'Node')

    Following.following(node, user).must_equal f
  end 

  it 'can follow only once' do
    user = create(:user)
    node = create(:node)
    f = Following.follow(node, user)
    Following.follow(node, user).must_equal f
  end
  
end
