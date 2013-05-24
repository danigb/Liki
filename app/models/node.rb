class Node < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :space, counter_cache: true

  belongs_to :parent, class_name: 'Node', counter_cache: :children_count
  has_many :children, -> { order 'position ASC' }, foreign_key: 'parent_id', 
    class_name: 'Node', dependent: :restrict_with_exception

  has_many :mentioned, foreign_key: 'to_id', class_name: 'Mention',
    dependent: :delete_all
  has_many :mentions, foreign_key: 'from_id', dependent: :delete_all
  has_many :mentioned_nodes, class_name: 'Node', through: :mentions,
    source: :to
  has_many :mentioned_by_nodes, class_name: 'Node', through: :mentioned,
    source: :from

  has_many :followings, as: :followed, dependent: :delete_all
  has_many :followers, through: :followings, source: :user, class_name: 'User'

  has_many :taggings, foreign_key: 'tag_id', dependent: :delete_all
  has_many :taggeds, through: :taggings

  has_many :accesses, dependent: :delete_all

  scope :imaged, -> { where("image <> '' OR dropbox_image_url <>''") }
  scope :slugged, -> { where("slug <> ''") }


  validates_presence_of :user_id, :space_id

  acts_as_list scope: [:space_id, :parent_id]
  include FriendlyId
  friendly_id :title, use: :scoped, scope: :space
  mount_uploader :image, ImageUploader
  mount_uploader :document, DocumentUploader
  attr_accessor :prevent_slug_creation

  ROLES = ['folder', 'document', 'slides', 'section', 'photo']

  before_validation :set_space_id

  def should_generate_new_friendly_id?
    !prevent_slug_creation && (new_record? && title.present?) || (title_changed? && slug.present?)
  end

  def rol
    @rol ||= Role.find(self.role)
  end

  def mentioner
    @mentioner ||= Mentioner.new(self)
  end

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
