class AddGroupInfo < ActiveRecord::Migration
  def change
    add_column :mentions, :group_id, :integer
    add_index :mentions, :group_id
    Mention.update_all(group_id: 2)

    add_column :groups, :nodes_count, :integer, default: 0
    add_column :groups, :mentions_count, :integer, default: 0
    
    add_column :users, :nodes_count, :integer, default: 0
  end
end
