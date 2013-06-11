class Space < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  belongs_to :photos_node, class_name: 'Node'
  has_many :mentions
  has_many :nodes
  has_many :photos
  has_many :followings, as: :followed, dependent: :delete_all
  has_many :followers, through: :followings, source: :user, class_name: 'User'
  has_many :activities, -> { order('updated_at DESC') }
  has_many :prototypes, -> { order('name ASC') }

  include HasMembers

  validates_presence_of :name, :user_id, :email

  mount_uploader :background_image, SpaceImageUploader

  after_create :create_space_node

  protected
  def create_space_node
    self.node = Node.create(title: self.name, body: self.name,
                            user: self.user, space: self)
    self.save
  end
end
