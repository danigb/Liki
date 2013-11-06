class Node < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :space, counter_cache: true

  has_many :photo_tags, dependent: :delete_all
  has_many :photos, -> { order('created_at DESC') }, 
    through: :photo_tags

  has_many :taggings, foreign_key: 'tag_id', dependent: :delete_all
  has_many :taggeds, through: :taggings

  has_one :event

  include HasMentions
  include HasFollowers
  include HasActivity
  include HasAccesses
  include HasPrototype
  include HasComments

  validates_presence_of :user_id, :space_id
  validates_presence_of :title
  validates_uniqueness_of :title, scope: :space_id, 
    case_sensitive: false

  has_ancestry orphan_strategy: :restrict
  acts_as_list scope: [:space_id, :ancestry]
  include FriendlyId
  friendly_id :title, use: :scoped, scope: :space
  mount_uploader :document, DocumentUploader
  acts_as_gmappable process_geocoding: :geocode?, checker: :geocoded

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

  def gmaps4rails_address
    "#{self.map_address}, spain"
  end

  def geocode?
    self.map_address.present?
  end

  protected
  def set_space_id
    self.space_id = self.parent.space_id if self.parent
  end
end
