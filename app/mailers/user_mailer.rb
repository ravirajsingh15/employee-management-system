class UserMailer < ApplicationMailer

  default from: "no-reply@rajravisingh9140@gmail.com"

  def signup_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: " Welcome to Employee Track System:"
    )
  end

  def reset_password_email
    @user = params[:user]
    @url  = edit_password_reset_url(token: @user.reset_password_token)
    mail(to: @user.email, subject: "Reset your password")
  end
end
