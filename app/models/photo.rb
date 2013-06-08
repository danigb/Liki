class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :space

  validates_presence_of :user_id, :space_id
  mount_uploader :image, PhotoImageUploader
end
