# Sends reply out to all users involved in the conversation.
# Uses the SendGrid SMTP api
# http://docs.sendgrid.com/documentation/api/smtp-api/
# http://paveltyk.github.com/sendgrid-rails/
class Users::ReplyMailer < Users::Mailer
  def prepare options

    @reply   = options[:reply]
    @sender  = options[:sender]
    @wedding = options[:wedding]
    @users   = options[:users]

    category 'Messages'
    substitute "-respond_url-", urls
    substitute "-recipients_name-", names

    mail to: emails,
         subject: "#{@sender.name} replied to a message for #{@wedding.title}",
         template_name: 'reply'
  end

  def emails
    @users.map do |user|
      user.email
    end
  end

  def urls
    @users.map do |user|
      wedding_timeline_url @wedding, subdomain: subdomain
    end
  end

  def names
    @users.map do |user|
      user.name
    end
  end
end
