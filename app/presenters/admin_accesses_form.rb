require 'reform/rails'

class AdminAccessesForm < Reform::Form
  include DSL
  include Reform::Form::ActiveModel

  model :admin, on: :node

  property :title, on: :node
  property :add_editor_user_name, on: :action
end
