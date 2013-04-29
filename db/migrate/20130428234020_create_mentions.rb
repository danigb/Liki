class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :from_id
      t.integer :to_id
    end
    add_index :mentions, :from_id
    add_index :mentions, :to_id

    add_column :nodes, :mentions_solved, :boolean, default: false
    add_column :nodes, :mentioned_count, :integer, default: 0
    add_column :nodes, :mentions_count, :integer, default: 0
  end
end
