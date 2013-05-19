class AddDropboxUrlToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :dropbox_image_url, :string
    add_index :nodes, :role
  end
end
