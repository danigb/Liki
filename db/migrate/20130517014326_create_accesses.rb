class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.integer :user_id
      t.integer :node_id

      t.boolean :visible, default: true
      t.integer :view_count, default: 0
      t.datetime :last_view_at

      t.integer :edit_level, default: 0
      t.integer :edit_count, default: 0
      t.datetime :last_edit_at

      t.string :auth_toker, limit: 50
      t.datetime :auth_token_created_at
      t.integer :auth_token_emailed, default: 0
    end
    add_index :accesses, :user_id
    add_index :accesses, :node_id

    add_column :nodes, :view_count, :integer, default: 0
  end
end
