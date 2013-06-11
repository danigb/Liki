class Comment < ActiveRecord::Base
  belongs_to :space
  belongs_to :node, counter_cache: true
  belongs_to :user
  belongs_to :reply_to, class_name: 'Comment'

  before_validation :set_space_id
  validates_presence_of :node_id, :space_id
  validates_presence_of :body

  acts_as_list scope: :node_id

  protected
  def set_space_id
    self.space_id = self.node.space_id if self.node
  end
end
