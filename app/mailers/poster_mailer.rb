class PosterMailer < ActionMailer::Base

  default :from => "WormBurner <wormburner@popzenith.com>"


  def new_message(message)
    @message = message
    mail(:to => "#{message.email}", :subject => "#{message.subject}", :content_type => 'text/html')
  end

end