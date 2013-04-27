class Node < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :parent, class_name: 'Node', counter_cache: :children_count
  has_many :children, -> { order 'position ASC' }, foreign_key: 'parent_id', class_name: 'Node'

  validates_presence_of :user_id, :group_id

  acts_as_list scope: [:group_id, :parent_id]
  include FriendlyId
  friendly_id :title, use: :scoped, scope: :group
  mount_uploader :image, ImageUploader

  before_validation :set_group_id

  protected
  def set_group_id
    self.group_id = self.parent.group_id if self.parent
  end
end
