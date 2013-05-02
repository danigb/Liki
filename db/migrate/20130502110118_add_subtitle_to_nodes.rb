class AddSubtitleToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :subtitle, :string, limit: 300
  end
end
