# Sends reply out to all users involved in the conversation.
# Uses the SendGrid SMTP api
# http://docs.sendgrid.com/documentation/api/smtp-api/
# http://paveltyk.github.com/sendgrid-rails/
class Users::ReplyMailer < Users::Mailer
  def subdomain
    'plan'
  end

  def prepare reply
    @reply = reply
    @sender = @reply.replyable

    category 'Messages'
    substitute "-invitation_url-", urls
    substitute "-recipients_name-", names

    mail to: emails,
         subject: "#{@message.messageable.name} has replied to your message.",
         template_name: 'reply'
  end

  def emails
    @guests.map do |guest|
      guest.email
    end
  end

  def urls
    @guests.map do |guest|
      invitation_url guest.token, subdomain: subdomain
    end
  end

  def names
    @guests.map do |guest|
      guest.name
    end
  end
end
