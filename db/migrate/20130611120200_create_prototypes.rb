class CreatePrototypes < ActiveRecord::Migration
  def change
    create_table :prototypes do |t|
      t.integer :space_id
      t.string :name, limit: 100 
      t.string :slug, limit: 100
      t.text :body
      t.string :order_options, limit: 30
      t.string :children_names, limit: 100
      t.timestamps
    end
    add_index :prototypes, :slug

    add_column :nodes, :prototype_id, :integer
    add_index :nodes, :prototype_id
  end
end
