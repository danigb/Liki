require 'test_helper'

describe NodesController do
  it 'shows login if not logged in' do
    node = create(:node)
    visit node_path(node)
    current_path.must_equal login_path
  end

  it 'shows node if logged in' do
    node = create(:node)
    login(create(:user))
    visit node_path(node)
    page.body.must_match node.title
  end

  it 'shows parent node on untitled' do
    parent = create(:node)
    node = create(:node, parent: parent, title: nil)
    login(create(:user))
    visit node_path(node)
    current_path.must_equal node_path(parent)
  end

end
