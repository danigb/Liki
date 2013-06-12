class AddNodesCountToPrototypes < ActiveRecord::Migration
  def change
    Prototype.destroy_all
    add_column :prototypes, :nodes_count, :integer, default: 0
  end
end
