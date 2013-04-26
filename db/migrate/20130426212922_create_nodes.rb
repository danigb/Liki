class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :title, limit: 300
      t.string :link_url, limit: 500
      t.string :image, limit: 300
      t.text :body
      t.integer :user_id
      t.integer :parent_id
      t.integer :position
      t.integer :children_count, default: 0
      t.timestamps
    end

    add_index :nodes, :parent_id
    add_index :nodes, :user_id
  end
end
