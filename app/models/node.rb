class Node < ActiveRecord::Base
  belongs_to :parent, class_name: 'Node', counter_cache: :children_count
  belongs_to :user

  validates_presence_of :user_id, :title

  acts_as_list scope: :parent_id
end
