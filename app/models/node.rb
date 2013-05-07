class Node < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :group, counter_cache: true
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


  validates_presence_of :user_id, :group_id, :body

  acts_as_list scope: [:group_id, :parent_id]
  include FriendlyId
  friendly_id :title, use: :scoped, scope: :group
  mount_uploader :image, ImageUploader
  mount_uploader :document, DocumentUploader

  before_validation :set_group_id

  def admin
    @admin ||= AdminNode.new(self)
  end

  def mentioner
    @mentioner ||= Mentioner.new(self)
  end

  def label
    title? ? title : "##{id}"
  end

  def profile?
    group.member(self.user).try(:node_id) == self.id
  end

  protected
  def set_group_id
    self.group_id = self.parent.group_id if self.parent
  end
end
