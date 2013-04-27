class Node < ActiveRecord::Base
  belongs_to :parent, class_name: 'Node', counter_cache: :children_count
  belongs_to :user
  belongs_to :group

  validates_presence_of :user_id, :group_id, :title

  acts_as_list scope: [:group_id, :parent_id]

  before_validation :set_group_id

  def to_param
    "#{id}-#{title.parameterize}"
  end

  protected
  def set_group_id
    self.group_id = self.parent.group_id if self.parent
  end
end
