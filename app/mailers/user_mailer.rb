class UserMailer < ActionMailer::Base
  default from: "lapelicanacrianza@gmail.com"

  def auth_token_email(member)
    @member = member
    @user = member.user
    @group = member.group
    mail to: @user.email, subject: "Enlace para entrar a #{@group.name}"
  end
end
