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
end
