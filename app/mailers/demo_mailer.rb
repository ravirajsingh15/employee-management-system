class DemoMailer < ApplicationMailer
  def admin_notification(demo)
    @demo = demo
    mail(to: "admin@demo.com", subject: "📅 New Demo Booking")
  end

  def user_confirmation(demo)
    @demo = demo
    mail(to: demo.email, subject: "Your demo request is confirmed")
  end
end
