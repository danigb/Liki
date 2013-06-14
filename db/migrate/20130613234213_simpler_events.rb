class SimplerEvents < ActiveRecord::Migration
  def change
    remove_column :events, :time
    remove_column :events, :node_id
    add_column :events, :time, :string
    add_column :events, :body, :text

    add_column :nodes, :event_id, :integer
    add_index :nodes, :event_id
  end
end
