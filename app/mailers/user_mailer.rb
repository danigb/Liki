class UserMailer < ActionMailer::Base
  default from: 'lapelicanacrianza@gmail.com'

  def auth_token_email(member)
    @member = member
    @user = member.user
    @space = member.space
    UserMailer.default_url_options[:host] = @space.host
    mail to: @user.email, from: @space.email,
      subject: "Enlace para entrar a #{@space.name}"
  end
end
