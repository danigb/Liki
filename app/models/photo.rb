class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :space
  has_many :photo_tags, dependent: :delete_all
  has_many :nodes, through: :photo_tags

  validates_presence_of :user_id, :space_id
  mount_uploader :image, PhotoImageUploader

  def tag(node)
    return unless node.present?
    tag = PhotoTag.where(node_id: node.id, photo_id: self.id).first
    tag ||= PhotoTag.create!(node: node, photo: self)
  end
end
