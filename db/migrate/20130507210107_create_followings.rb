class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :followed_id
      t.string :followed_type, limit: 16
      t.datetime :created_at
    end
    add_index :followings, :user_id
    add_index :followings, [:followed_id, :followed_type]

    add_column :users, :followings_count, :integer, default: 0
    add_column :nodes, :followers_count, :integer, default: 0
    add_column :groups, :followers_count, :integer, default: 0

    Node.find_each do |node|
      Following.follow(node, node.user)
    end


  end
end
