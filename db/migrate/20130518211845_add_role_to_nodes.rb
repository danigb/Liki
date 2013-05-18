class AddRoleToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :role, :string, limit: 8
    add_column :nodes, :image_style, :string, limit: 16
  end
end
