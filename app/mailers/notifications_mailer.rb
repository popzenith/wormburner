class NotificationsMailer < ActionMailer::Base

  default :from => "GolfPals Notification <noreply@golfpals.co>"
  default :to => "jlnovosad@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "#{message.subject}")
  end

end