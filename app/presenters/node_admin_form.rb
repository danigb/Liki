class NodeAdminFormPresenter < FormPresenter
  attr_accessor :title, on: :node
  attr_accessor :move_to_parent, on: :action
  attr_accessor :change_owner, on: :action
  attr_accessor :remove_slug, on: :action
  attr_accessor :reorder_children, on: :action
  attr_accessor :reorder_alphabetically, on: :action
  attr_accessor :children_role, on: :action
end
