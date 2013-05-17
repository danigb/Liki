class Tagging < ActiveRecord::Base
  belongs_to :tag, class_name: 'Node', counter_cache: :tagged_count
  belongs_to :tagged, class_name: 'Node'
  acts_as_list scope: :tag_id
end
