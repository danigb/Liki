class AddAncestryToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :ancestry, :string
    add_index :nodes, :ancestry

    Node.build_ancestry_from_parent_ids!
    Node.check_ancestry_integrity!

    remove_column :nodes, :parent_id
  end
end
