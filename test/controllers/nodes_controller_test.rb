require 'test_helper'

describe NodesController do
  describe 'Show' do
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

    it 'shows parent node if using id' do
      parent = create(:node)
      node = create(:node, parent: parent, title: nil)
      login(create(:user))
      visit node_path(node)
      current_path.must_equal node_path(parent)
    end

    it 'shows form if page not found' do
      create(:space)
      login(create(:user))
      visit node_path('something')
      page.find('#node_title').must_be :present?
    end
  end

  it 'creates nodes' do
    create(:space)
    user = login(create(:user))
    visit new_node_path
    fill_in 'node_title', with: 'The title'
    fill_in 'node_body', with: 'The body'
    click_submit
    page.body.must_match 'The title'
    page.body.must_match 'The body'
    Node.last.followers.must_include user
  end

  it 'update metions when updated' do
    g = create(:space)
    login(create(:user))
    uno = create(:node, title: 'Uno', space: g)
    dos = create(:node, title: 'Dos', space: g)
    visit edit_node_path(dos)
    fill_in 'node_body', with: '#Uno linkeado'
    click_submit
    page.body.must_match 'Uno linkeado'

    visit node_path(uno)
    page.find('.mentioned_by').text.must_match 'Dos'
  end

  describe 'Node admin' do
    it 'reorder nodes' do
      g = create(:space)
      login(create(:user, admin: true))
      p = create(:node, space: g)
      b = create(:node, title: 'b', parent: p)
      a = create(:node, title: 'a', parent: p)
      a.position.must_equal 2
      b.position.must_equal 1
      visit admin_node_path(p)
      check 'node_admin_reorder_alphabetically'
      click_submit 'node-admin'
      a.reload
      a.position.must_equal 1
      b.reload
      b.position.must_equal 2
    end

  end

end
