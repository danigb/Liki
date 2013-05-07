class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  has_many :members
  has_many :mentions
  has_many :users, through: :members
  has_many :nodes

  validates_presence_of :name, :user_id

  after_create :create_group_node

  def member(user)
    Member.where(group_id: self.id, user_id: user.id).first if user
  end

  def regenerate_counters
    Group.reset_counters(self.id, :nodes, :mentions, :members)
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
  def create_group_node
    self.node = Node.create(title: self.name, user: self.user, group: self)
    self.save
  end
end
