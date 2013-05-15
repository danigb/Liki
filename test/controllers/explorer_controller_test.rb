require 'test_helper'

describe ExplorerController do
  it 'shows map' do
    create(:space)
    visit map_path
  end

end
