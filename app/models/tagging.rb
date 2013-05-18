class Tagging < ActiveRecord::Base
  belongs_to :space
  belongs_to :tag, class_name: 'Node', counter_cache: :tagged_count
  belongs_to :tagged, class_name: 'Node'
  acts_as_list scope: :tag_id

  validates_presence_of :space_id, :tag_id, :tagged_id
  before_validation :add_space_id

  protected
  def add_space_id
    self.space_id = tag.space_id if self.tag
  end
end
