class RenameGroupToSpaceAndAddHost < ActiveRecord::Migration
  def change
    rename_table :groups, :spaces
    rename_column :members, :group_id, :space_id
    rename_column :mentions, :group_id, :space_id
    rename_column :nodes, :group_id, :space_id
    add_column :spaces, :host, :string, limit: 100
    add_index :spaces, :host
  end
end
