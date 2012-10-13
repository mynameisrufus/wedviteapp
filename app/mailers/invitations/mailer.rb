class Invitations::Mailer < ActionMailer::Base
  default from: "WedVite <noreply@wedviteapp.com>"

  layout 'mailer'

  def subdomain
    'invitations'
  end

  def invite(options)
    category 'Invitations'

    @wedding = options[:wedding]
    @user = options[:user]

    emails = options[:guests].map { |guest| guest.email } 
    urls = options[:guests].map { |guest| invitation_url guest.token, subdomain: subdomain }
    names = options[:guests].map { |guest| guest.name }

    substitute "-invitation_url-", urls
    substitute "-guest_name-", names

    mail to: emails,
         subject: "Invitation to #{@wedding.title}"
  end

  def message_email(options)
    category 'Messages'

    emails = options[:guests].map { |guest| guest.email }
    @message = options[:message]
    @user = options[:user]

    urls = options[:guests].map { |guest| invitation_url guest.token, subdomain: subdomain }
    names = options[:guests].map { |guest| guest.name }

    substitute "-invitation_url-", urls
    substitute "-guest_name-", names

    mail to: emails,
         subject: "New message from #{@user.name}"
  end

  def reply_email(options)
    category 'Messages'

    emails = options[:guests].map { |guest| guest.email }
    @message = options[:message]
    @user = @message.messageable

    urls = options[:guests].map { |guest| invitation_url guest.token, subdomain: subdomain }
    names = options[:guests].map { |guest| guest.name }

    substitute "-invitation_url-", urls
    substitute "-guest_name-", names

    mail to: emails,
         subject: "#{@message.messageable.name} has replied to your message."
  end

  class Preview < MailView
    def invitation
      ::Invitations::Mailer.invite wedding: Spoof.wedding,
                                   guests: [Spoof.guest, Spoof.guest],
                                   user: Spoof.user
    end

    def message_email
      ::Invitations::Mailer.message_email message: Spoof.message,
                                          guests: [Spoof.guest, Spoof.guest],
                                          user: Spoof.user
    end

    def reply_email
      ::Invitations::Mailer.reply_email message: Spoof.message,
                                        guests: [Spoof.guest, Spoof.guest]
    end
  end

  def send_mail_to_guests
    # Collect all the guests involved in the conversation.
    guests = @message.replies.collect do |reply|
      reply.by? :guest
    end

    # Add in original message poster, guest or user.
    recipients << @message.messageable if @message.by? :guest

    # Remove poster from recipients.
    recipients.delete @guest

    mail = Invitations::Mailer.reply_email({
      message: @message,
      reply: @reply,
      recipients: recipients,
      sender: @guest
    })

    mail.deliver
  end

  def send_mail_to_users


  end

end
