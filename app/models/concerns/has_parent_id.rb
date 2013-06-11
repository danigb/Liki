class Concerns::HasParentId
  extend ActiveSupport::Concern

  included do
    belongs_to :parent, class_name: 'Node', counter_cache: :children_count

    has_many :children, 
      -> { where("role IS NULL OR role <> 'photo'").order('position ASC') },
      foreign_key: 'parent_id', 
      class_name: 'Node', dependent: :restrict_with_exception

  end
end
