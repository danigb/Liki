require 'test_helper'

describe Mentioner do
  it 'update mentions' do
    g = create(:space)
    u = create(:node, title: 'uno', space: g)
    uu = create(:node, title: 'uno-uno', space: g)
    node = create(:node, body: 'Esto es #Uno, #Dos y #UnoUno', space: g)
    node.mentioner.update_mentions
    node.mentions.count.must_equal 2
    node.mentioned_nodes.must_include u
    node.mentioned_nodes.must_include uu
    node.mentions_solved.must_equal false
    d = create(:node, title: 'dos', space: g)
    node.mentioner.update_mentions
    node.mentions.count.must_equal 3
    node.mentions_solved.must_equal true
  end

  it 'extract mentions' do
    a = create(:node, title: 'Ángela')
    b = create(:node, space: a.space, body: '#Ángela')
    b.mentioner.update_mentions
    b.mentioned_nodes.must_include a
  end
end
