require 'test_helper'

describe NodeService do
  describe 'add children' do
    let(:user) { create(:user) }
    let(:parent) { create(:node, group: create(:group)) }

    it 'adds text as body' do
      node = NodeService.add_children("blahblah", parent, user)
      node.title.must_equal nil
      node.body.must_equal 'blahblah'
    end

    it 'adds first line as title if separated from rest' do
      node = NodeService.add_children("a\r\n\r\nb", parent, user)
      node.title.must_equal 'a'
      node.body.must_equal 'b'
    end
  end

  describe 'update mentions' do
    it 'update mentions' do
      u = create(:node, title: 'uno')
      uu = create(:node, title: 'uno-uno')
      node = create(:node, body: 'Esto es #Uno, #Dos y #UnoUno')
      NodeService.update_mentions(node)
      node.mentions.count.must_equal 2
      node.mentioned_nodes.must_include u
      node.mentioned_nodes.must_include uu
      node.mentions_solved.must_equal false
      d = create(:node, title: 'dos')
      NodeService.update_mentions(node)
      node.mentions.count.must_equal 3
      node.mentions_solved.must_equal true
    end
  end

  describe 'extract mentions' do
    it 'extract mentions' do
      mentions = NodeService.extract_mentions('A is #FirstLetter of @Alphabet.')
      mentions.count.must_equal 2
      mentions[0].must_equal '#FirstLetter'
      mentions[1].must_equal '@Alphabet'
    end
  end
end
