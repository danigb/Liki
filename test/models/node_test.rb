require 'test_helper'

describe Node do
  it 'can have not title' do
    node = create(:node, title: nil, group: create(:group))
    node.slug.must_equal nil
    node.to_param.must_equal node.id.to_s
  end

  describe 'Parent and children' do
    it "can have parent" do
      parent = create(:node, group: create(:group))
      children = create(:node, parent: parent)
      children.parent.must_equal parent
      children.group.must_equal parent.group
    end

    it 'can have children' do
      parent = create(:node, group: create(:group))
      c1 = create(:node, parent: parent)
      c2 = create(:node, parent: parent)
      parent.children.must_include c1
      parent.children.must_include c2
    end

    it "children have order" do
      g = create(:group)

      parent1 = create(:node, group: g)
      parent1.position.must_equal 2 # first is group node

      c1 = create(:node, parent: parent1)
      c2 = create(:node, parent: parent1)
      c1.position.must_equal 1
      c2.position.must_equal 2

      parent2 = create(:node, group: g)
      parent2.position.must_equal 3
    end

    it 'can not delete if children' do
      p = create(:node)
      c = create(:node, parent: p)
      p.reload
      p.children.size.must_equal 1
      p.destroy
      # TODO: arreglar esto
      # p.destroyed?.must_equal false
    end
  end

  describe 'mentions' do
    it 'have mentions' do
      a = create(:node)
      b = create(:node, group: a.group)
      m = Mention.mention(a, b)
      a.mentions.must_include m
      b.mentioned.must_include m
      a.mentioned_nodes.must_include b
      b.mentioned_by_nodes.must_include a
    end
  end
end

