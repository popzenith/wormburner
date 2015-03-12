class NotificationsMailer < ActionMailer::Base

  default :from => "WormBurner <wormburner@popzenith.com>"
  default :to => "jlnovosad@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "#{message.subject}")
  end

end