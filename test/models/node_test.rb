require 'test_helper'

describe Node do
  it "can have parent" do
    parent = create(:node)
    children = create(:node, parent: parent)
    children.parent.must_equal parent
  end

  it "children have order" do
    parent = create(:node)
    c1 = create(:node, parent: parent)
    c2 = create(:node, parent: parent)
    c1.position.must_equal 1
    c2.position.must_equal 2

    c3 = create(:node, parent: create(:node))
    c3.position.must_equal 1
  end
end

