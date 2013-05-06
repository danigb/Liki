require 'test_helper'

describe Mentioner do
  it 'update mentions' do
    u = create(:node, title: 'uno')
    uu = create(:node, title: 'uno-uno')
    node = create(:node, body: 'Esto es #Uno, #Dos y #UnoUno')
    node.mentioner.update_mentions
    node.mentions.count.must_equal 2
    node.mentioned_nodes.must_include u
    node.mentioned_nodes.must_include uu
    node.mentions_solved.must_equal false
    d = create(:node, title: 'dos')
    node.mentioner.update_mentions
    node.mentions.count.must_equal 3
    node.mentions_solved.must_equal true
  end

end
