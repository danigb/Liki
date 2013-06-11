class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :space_id
      t.integer :node_id
      t.integer :user_id
      t.integer :reply_to_id
      t.integer :position, default: 0
      t.text :body
      t.timestamps
    end

    add_index :comments, :space_id
    add_index :comments, :node_id
    add_index :comments, :user_id
    add_index :comments, :reply_to_id

    add_column :nodes, :comments_count, :integer, default: 0
  end
end
