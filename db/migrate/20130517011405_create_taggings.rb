class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :tagged_id
      t.integer :position
      t.datetime :created_at
    end

    add_column :nodes, :taggings_count, :integer, default: 0
  end
end
