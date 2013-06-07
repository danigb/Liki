class Access < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  belongs_to :space

  validates_presence_of :space_id, :node_id, :user_id
  before_validation :add_space_id

  NO_EDIT = 0 # Can't edit
  EDITOR = 1 # Can update
  OWNER = 2 # Can update and destroy
  ADMIN = 3 # Can admin

  def denied?
    false
  end

  def view!
    self.view_count = self.view_count + 1
    self.last_view_at = Time.now
    save
  end

  protected
  def add_space_id
    self.space_id = node.space_id if self.node
  end
end
