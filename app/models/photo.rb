class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :space
  has_many :photo_tags
  has_many :nodes, through: :photo_tags

  validates_presence_of :user_id, :space_id
  mount_uploader :image, PhotoImageUploader
end
