require 'test_helper'

describe Comment do
  let(:node) { create(:node) }

  it 'has order' do
    c1 = create(:comment, node: node)
    c1.position.must_equal 1
    c2 = create(:comment, node: node)
    c2.position.must_equal 2
    create(:comment).position.must_equal 1
  end
end
