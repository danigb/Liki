require 'test_helper'

describe Mentioner do
  it 'update mentions' do
    g = create(:group)
    u = create(:node, title: 'uno', group: g)
    uu = create(:node, title: 'uno-uno', group: g)
    node = create(:node, body: 'Esto es #Uno, #Dos y #UnoUno', group: g)
    node.mentioner.update_mentions
    node.mentions.count.must_equal 2
    node.mentioned_nodes.must_include u
    node.mentioned_nodes.must_include uu
    node.mentions_solved.must_equal false
    d = create(:node, title: 'dos', group: g)
    node.mentioner.update_mentions
    node.mentions.count.must_equal 3
    node.mentions_solved.must_equal true
  end

  it 'extract mentions' do
    m = Mentioner.extract_mentions('#Uno #dos')
    puts m


  end
end
