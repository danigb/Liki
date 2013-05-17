class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :tagged_id
      t.integer :position
      t.datetime :created_at
    end

    add_index :taggings, :tag_id
    add_index :taggings, :tagged_id

    add_column :nodes, :tagged_count, :integer, default: 0
  end
end
