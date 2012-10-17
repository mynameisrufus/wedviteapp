class Invitations::MessageMailer < Invitations::Mailer
  def prepare options

    @message = options[:message]
    @sender  = options[:sender]
    @wedding = options[:wedding]
    @guests  = options[:guests]

    category 'Messages'
    substitute "-invitation_url-", urls

    mail to: emails,
         subject: "Message from #{@sender.name} about #{@wedding.title}.",
         template_name: 'message'
  end
end
