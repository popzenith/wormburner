class PosterMailer < ActionMailer::Base

  default :from => "WormBurner <wormburner@popzenith.com>"


  def new_message(message)
    @message = message
    mail(
      :subject 			=> "#{message.subject}",
      :to      			=> "#{message.email}",
      :content_type => 'text/html'
    )
  end

  

end