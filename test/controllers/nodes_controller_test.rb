require 'test_helper'

describe NodesController do
  let(:space) { create(:space) }
  let(:member) { space.add_member(create(:user)).user }
  let(:not_member) { create(:user) }
  let(:node) { create(:node, space: space) }

  describe 'Show' do
    it 'shows login if not logged in' do
      visit node_path(node)
      current_path.must_equal login_path
    end

    it 'shows node if logged in' do
      login(member)
      visit node_path(node)
      page.body.must_match node.title
    end

    it 'shows form if page not found' do
      login(member)
      visit node_path('something')
      page.find('#node_title').must_be :present?
    end
  end

  it 'creates nodes' do
    login(member)
    visit new_node_path
    fill_in 'node_title', with: 'The title'
    fill_in 'node_body', with: 'The body'
    click_submit
    page.body.must_match 'The title'
    page.body.must_match 'The body'
    Node.last.followers.must_include member
  end

  it 'update metions when updated' do
    login(member)
    uno = create(:node, title: 'Uno', space: space)
    dos = create(:node, title: 'Dos', space: space)
    visit edit_node_path(dos)
    fill_in 'node_body', with: '#Uno linkeado'
    click_submit
    uno.mentions.must_include dos
  end

  describe 'Node admin' do
    it 'reorder nodes' do
      login(member)
      p = create(:node, space: space)
      b = create(:node, title: 'b', parent: p)
      a = create(:node, title: 'a', parent: p)
      a.position.must_equal 2
      b.position.must_equal 1
      visit admin_node_path(p)
      check 'node_admin_form_presenter_reorder_alphabetically'
      click_submit 'node-admin'
      a.reload
      a.position.must_equal 1
      b.reload
      b.position.must_equal 2
    end
  end
end
