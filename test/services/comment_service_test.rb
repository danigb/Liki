require 'test_helper'

describe CommentService do
  let(:node) { create(:node) }
  let(:space) { node.space }
  let(:user) { create(:user) }
  let(:service) { CommentService.new(user, space) }
  
  it 'creates comment' do
    service.create(node, body: 'Comment')
    service.must_be :succeed?
    service.comment.space.must_equal space
    service.comment.user.must_equal user
    service.comment.body.must_equal 'Comment'
  end

end
