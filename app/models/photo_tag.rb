class PhotoTag < ActiveRecord::Base
  belongs_to :photo
  belongs_to :node
  belongs_to :space

  validates_presence_of :photo_id, :node_id, :space_id

  before_validation :set_space_id

  protected
  def set_space_id
    self.space_id ||= node.space_id
  end
end
