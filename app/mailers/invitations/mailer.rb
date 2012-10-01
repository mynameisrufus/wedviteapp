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

  class Preview < MailView
    def invitation
      ::Invitations::Mailer.invite wedding: Spoof.wedding,
                                   guests: [Spoof.guest, Spoof.guest],
                                   user: Spoof.user
    end
  end
end
