require 'reform/rails'

class AccessAdminForm < Reform::Form
  include DSL
  include Reform::Form::ActiveModel

  model :access_admin, on: :node

  property :title, on: :node
  property :add_editor_user_name, on: :action

  def validate(params)
    super(params) if params.present?
  end
end
