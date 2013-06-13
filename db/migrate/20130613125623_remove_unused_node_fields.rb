class RemoveUnusedNodeFields < ActiveRecord::Migration
  def change
    remove_column :nodes, :has_children
    remove_column :nodes, :has_photos
    remove_column :nodes, :children_name
  end
end
