class Invitations::Mailer < ActionMailer::Base
  default from: "noreply@wedviteapp.com"

  layout 'mailer'

  def subdomain
    'invitations'
  end

  def invite(options)
    @user  = options[:user]
    @guest = options[:guest]
    @url   = invitation_url @guest.token, subdomain: subdomain

    mail to: @guest.email,
         from: "WedVite <noreply@wedviteapp.com>",
         subject: "Invitation to #{@guest.wedding.title}"
  end

  class Preview < MailView
    def invitation
      ::Invitations::Mailer.invite user: Spoof.user,
                                   guest: Spoof.guest
    end
  end
end
