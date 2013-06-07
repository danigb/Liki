class AccessDenied
  attr_reader :user, :cause

  def initialize(user, cause)
    @user = user
    @cause = cause
  end

  def denied?
    true
  end
end
