class Group < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  has_many :members
  has_many :users, through: :members
  has_many :nodes

  validates_presence_of :name, :user_id

  after_create :create_group_node

  def member(user)
    Member.where(group_id: self.id, user_id: user.id).first if user
  end

  protected
  def create_group_node
    self.node = Node.create(title: self.name, user: self.user, group: self)
    self.save
  end
end
