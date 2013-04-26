class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, limit: 100
      t.integer :members_count, default: 0
      t.integer :node_id
      t.timestamps
    end
    add_index :groups, :node_id

    create_table :members do |t|
      t.integer :group_id
      t.integer :user_id
      t.string :auth_token, limit: 50, unique: true
      t.datetime :auth_token_created_at
      t.boolean :active, default: true
      t.integer :login_count, default: 0
      t.datetime :last_login_at
      t.datetime :created_at
    end
    add_index :members, :group_id
    add_index :members, :user_id
  end
end
