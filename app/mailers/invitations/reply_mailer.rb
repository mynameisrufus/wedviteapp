class Invitations::ReplyMailer < Invitations::Mailer
  def prepare options
    @reply   = options[:reply]
    @sender  = options[:sender]
    @wedding = options[:wedding]
    @guests  = options[:guests]

    category 'Messages'
    substitute "-invitation_url-", urls

    mail to: emails,
         subject: "#{@sender.name} replied to a message for #{@wedding.title}",
         template_name: 'reply'
  end
end
