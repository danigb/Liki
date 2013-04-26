require 'test_helper'

describe Node do
  it "can have parent" do
    parent = create(:node, group: create(:group))
    children = create(:node, parent: parent)
    children.parent.must_equal parent
    children.group.must_equal parent.group
  end

  it "children have order" do
    g = create(:group)

    parent1 = create(:node, group: g)
    parent1.position.must_equal 1

    c1 = create(:node, parent: parent1)
    c2 = create(:node, parent: parent1)
    c1.position.must_equal 1
    c2.position.must_equal 2

    parent2 = create(:node, group: g)
    parent2.position.must_equal 2
  end
end

