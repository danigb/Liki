class AddPhotoRole < ActiveRecord::Migration
  def change
    Node.where(title: nil).imaged.update_all(role: 'photo')
  end
end
