class AddChildrenOptionsToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :has_children, :boolean, default: false
    add_column :nodes, :has_photos, :boolean, default: false
    add_column :nodes, :children_name, :string, limit: 30
  end
end
