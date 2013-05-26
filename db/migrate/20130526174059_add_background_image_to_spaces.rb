class AddBackgroundImageToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :background_image, :string
    add_column :spaces, :avatar_image, :string
  end
end
