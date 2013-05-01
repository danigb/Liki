class AddDocumentToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :document, :string, limit: 300
    remove_column :nodes, :link_url
  end
end
