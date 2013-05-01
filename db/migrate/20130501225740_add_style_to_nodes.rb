class AddStyleToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :style, :string, limit: 8
  end
end
