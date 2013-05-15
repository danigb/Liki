class UserMailer < ActionMailer::Base
  default from: 'lapelicanacrianza@gmail.com'

  def auth_token_email(member)
    @member = member
    @user = member.user
    @space = member.space
    mail to: @user.email, subject: "Enlace para entrar a #{@space.name}"
  end
end
