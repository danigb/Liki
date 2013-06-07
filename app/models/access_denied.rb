class AccessDenied < Exception
  attr_reader :user, :cause

  def initialize(user, cause)
    super(cause)
    @user = user
    @cause = cause
  end

  def denied?
    true
  end
end
