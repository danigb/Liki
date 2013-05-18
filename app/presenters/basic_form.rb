require 'reform/rails'

class BasicForm < Reform::Form
  include DSL
  include Reform::Form::ActiveModel

  def validate(params)
    super(params) if params.present?
  end
end

