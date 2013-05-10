require 'test_helper'

describe Mention do
  it 'can mention' do
    n1 = create(:node)
    n2 = create(:node, space: n1.space)
    m = Mention.mention(n1, n2)
    m.from.must_equal n1
    m.to.must_equal n2
    Mention.mention(n1, n2).must_equal m
  end

  it 'nodes have mentioned and mentions' do
    a = create(:node)
    b = create(:node, space: a.space)
    m = Mention.mention(a, b)
    a.mentions.must_include m
    b.mentioned.must_include m
    a.reload
    a.mentions_count.must_equal 1
    b.reload
    b.mentioned_count.must_equal 1
  end
end
