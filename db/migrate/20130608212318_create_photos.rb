class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :space_id
      t.integer :user_id
      t.string :image
      t.string :dropbox_image_url
      t.string :body
      t.string :style, limit: 16
      t.timestamps
    end
    add_index :photos, :user_id
    add_index :photos, :space_id

    add_column :nodes, :image_url, :string

    Node.find_each do |node|
      if node.image.present?
        photo = Photo.create!(
          space: node.space, user: node.user,
          created_at: node.created_at, updated_at: node.updated_at)
        photo.update_column(:image, node.image)

        if node.title.blank?
          node.destroy
        else
          node.update_attributes(image_url: photo.image.url)
        end
      end
    end

    remove_column :nodes, :image
    remove_column :nodes, :dropbox_image_url
  end
end
