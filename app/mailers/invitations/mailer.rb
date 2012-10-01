class Invitations::Mailer < ActionMailer::Base
  include SendGrid
  sendgrid_category "Invitation"

  default from: "noreply@wedviteapp.com"

  layout 'mailer'

  def subdomain
    'invitations'
  end

  def invite(options)

    emails = options[:guests].map { |guest| guest.email }
    sendgrid_recipients emails

    urls = options[:guests].map { |guest| invitation_url guest.token, subdomain: subdomain }
    sendgrid_substitute "{{url}}", urls

    names = options[:guests].map { |guest| guest.name }
    sendgrid_substitute "{{name}}", names

    @wedding = options[:wedding]
    @user = options[:user]

    mail from: "WedVite <noreply@wedviteapp.com>",
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
