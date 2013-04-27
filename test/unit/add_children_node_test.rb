require 'test_helper'

describe AddChildrenNode do
  it 'adds first line as title' do
    user = create(:user)
    p = create(:node, group: create(:group))
    
    add = AddChildrenNode.new("a\nb\nc", p, user)
    add.save.must_equal true
    add.node.title.must_equal 'a'
    add.node.body.must_equal "b\nc"
  end
end
