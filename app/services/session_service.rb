class SessionService
  attr_reader :current_space
  def initialize(current_space)
    @current_space = current_space
  end

  def authorize_token(id)
    member = current_space.members.find_by_auth_token(id)
    enter_with member
  end

  def login(form)
    if form.valid?
      user = User.find_by_email(form.email)
      if user && user.authenticate(form.password)
        enter_with current_space.member(user)
      end
    end
  end

  private
  def enter_with(member)
    return unless member.present?
    member.update_attributes(
      last_login_at: Time.now, 
      login_count: member.login_count + 1)
    member.user
  end
end
