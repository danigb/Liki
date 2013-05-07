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

  it 'shows mentions' do
    g = create(:group)
    login(create(:user))
    uno = create(:node, title: 'Uno', group: g)
    dos = create(:node, title: 'Dos', group: g)
    visit edit_node_path(dos)
    fill_in 'node_body', with: '#Uno linkeado'
    click_submit
    page.body.must_match 'Uno linkeado'

    visit node_path(uno)
    page.find('.mentioned_by').text.must_match 'Dos'
  end

end
