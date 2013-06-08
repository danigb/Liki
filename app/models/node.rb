class Node < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :space, counter_cache: true

  belongs_to :parent, class_name: 'Node', counter_cache: :children_count

  has_many :children, 
    -> { where("role IS NULL OR role <> 'photo'").order('position ASC') },
    foreign_key: 'parent_id', 
    class_name: 'Node', dependent: :restrict_with_exception

  has_many :photos, 
    -> { where(role: 'photo').order('created_at DESC') }, 
    foreign_key: 'parent_id', 
    class_name: 'Node', dependent: :restrict_with_exception

  has_many :taggings, foreign_key: 'tag_id', dependent: :delete_all
  has_many :taggeds, through: :taggings

  include HasMentions
  include HasFollowers
  include HasActivity
  include HasAccesses

  scope :imaged, -> { where("image <> '' OR dropbox_image_url <>''") }
  scope :slugged, -> { where("slug <> ''") }

  validates_presence_of :user_id, :space_id
  validates_presence_of :title
  validates_uniqueness_of :title, scope: :space_id

  acts_as_list scope: [:space_id, :parent_id]
  include FriendlyId
  friendly_id :title, use: :scoped, scope: :space
  mount_uploader :document, DocumentUploader

  before_validation :set_space_id

  def label
    title? ? title : "##{id}"
  end

  def profile?
    space.member(self.user).try(:node_id) == self.id
  end

  protected
  def set_space_id
    self.space_id = self.parent.space_id if self.parent
  end
end
