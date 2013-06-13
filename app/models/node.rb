class Node < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :space, counter_cache: true

  has_many :photo_tags, dependent: :delete_all
  has_many :photos, -> { order('created_at DESC') }, 
    through: :photo_tags

  has_many :taggings, foreign_key: 'tag_id', dependent: :delete_all
  has_many :taggeds, through: :taggings

  include HasMentions
  include HasFollowers
  include HasActivity
  include HasAccesses
  include HasPrototype
  include HasComments

  validates_presence_of :user_id, :space_id
  validates_presence_of :title
  validates_uniqueness_of :title, scope: :space_id

  has_ancestry
  acts_as_list scope: [:space_id, :ancestry]
  include FriendlyId
  friendly_id :title, use: :scoped, scope: :space
  mount_uploader :document, DocumentUploader

  before_validation :set_space_id

  def profile?
    space.member(self.user).try(:node_id) == self.id
  end

  def ordered_children
    self.proto.order(self.children)
  end

  def document_title
    File.basename(document.url)
  end

  protected
  def set_space_id
    self.space_id = self.parent.space_id if self.parent
  end
end
