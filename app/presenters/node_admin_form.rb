require 'reform/rails'

class NodeAdminForm < Reform::Form
  include DSL
  include Reform::Form::ActiveModel

  model :node_admin, on: :node
  
  property :title, on: :node
  property :move_to_parent, on: :action
  property :change_owner, on: :action
  property :remove_slug, on: :action
  property :reorder_children, on: :action
  property :reorder_alphabetically, on: :action

  def validate(params)
    super(params) if params.present?
  end

end
