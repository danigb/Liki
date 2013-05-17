class Access < ActiveRecord::Base
  belongs_to :user
  belongs_to :node

  NO_EDIT = 0 # Can't edit
  EDITOR = 1 # Can update
  OWNER = 2 # Can update and destroy
  ADMIN = 3 # Can admin

  validates_presence_of :user_id, :node_id

  def self.get(node, user)
    return if node.blank? || user.blank?
    access = Access.where(node_id: node.id, user_id: user.id).first
    access ||= Access.create!(node: node, user: user)
  end

  def view!
    self.view_count = self.view_count + 1
    self.last_view_at = Time.now
    save
  end
end
