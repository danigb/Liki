class ApplicationService
  attr_accessor :current_user, :current_space

  def initialize(user, space)
    @current_user = user
    @current_space = space
    @current_ability = Ability.new(user, space)
    @succeed = false
  end

  def save(model)
    @succeed = model.save
    yield if block_given? && @succeed
    @succeed
  end

  def succeed?
    @succeed
  end

  protected
  def authorize!(*args)
    @current_ability.authorize!(*args)
  end
end
