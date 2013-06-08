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

  include HasMembers

  validates_presence_of :name, :user_id, :email

  mount_uploader :background_image, SpaceImageUploader

  after_create :create_space_node

  def regenerate_counters
    Space.reset_counters(self.id, :nodes, :mentions, :members)
    self.nodes.pluck(:id).each do |node_id|
      Node.reset_counters node_id, :children
    end
  end

  def regenerate_mentions
    Mention.destroy_all
    self.nodes.find_each do |node|
      node.mentioner.update_mentions
    end
  end

  def label
    name
  end

  protected
  def create_space_node
    self.node = Node.create(title: self.name, body: self.name,
                            user: self.user, space: self)
    self.save
  end
end
