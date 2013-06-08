class CreatePhotoTags < ActiveRecord::Migration
  def change
    create_table :photo_tags do |t|
      t.integer :photo_id
      t.integer :node_id
      t.integer :space_id
      t.datetime :created_at
    end
    add_index :photo_tags, :photo_id
    add_index :photo_tags, :node_id
    add_index :photo_tags, :space_id

    add_column :spaces, :photos_node_id, :integer

    Space.find_each do |space|
      photos = Node.create!(space: space, user: space.user,
                           title: 'Photos', parent: space.node)
      space.update_attribute(:photos_node_id, photos.id)

      space.photos.each do |photo|
        PhotoTag.create!(node: photos, photo: photo)
        if photo.body?
          node = Node.find(photo.body)
          PhotoTag.create!(node: node, photo: photo)
          photo.update_attributes(body: nil)
        end
      end
    end
  end
end
