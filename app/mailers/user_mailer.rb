class UserMailer < ApplicationMailer

  default from: "no-reply@rajravisingh9140@gmail.com"

  def signup_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: " Welcome to Employee Track System:"
    )
  end
end
