require 'reform/rails'

class FollowingAdminForm < Reform::Form
  include DSL
  include Reform::Form::ActiveModel

  model :following_admin, on: :node
  
  property :title, on: :node
  property :add_follower_user_name, on: :action

  def validate(params)
    super(params) if params.present?
  end

end

