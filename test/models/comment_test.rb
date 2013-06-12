require 'test_helper'

describe Comment do
  let(:node) { create(:node) }
  let(:user) { create(:user) }

  it 'has order' do
    c1 = create(:comment, node: node)
    c1.position.must_equal 1
    c2 = create(:comment, node: node)
    c2.position.must_equal 2
    create(:comment).position.must_equal 1
  end

  it 'has reply_to' do
    comment = node.comment(user, body: 'c1')
    reply = node.comment(user, body: 'c2', reply_to: comment)
    reply.reply_to.must_equal comment
  end
end
