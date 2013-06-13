class AddGeodataToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :latitude, :float
    add_column :nodes, :longitude, :float
    add_column :nodes, :map_address, :string
    add_column :nodes, :geocoded, :boolean, default: false
  end
end
