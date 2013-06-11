require 'test_helper'

class HasCommentsTest < ActiveSupport::TestCase
  let(:node) { create(:node) }
  let(:user) { create(:user) }

  it 'can create comments' do
    comment = node.comment(user, body: 'My comment')
    comment.must_be :present?
    comment.node.must_equal node
    comment.user.must_equal user
  end

  it 'has nodes' do
    comment = create(:comment, node: node)
    node.comments.must_include comment
    node.reload
    node.comments_count.must_equal 1
  end
end
