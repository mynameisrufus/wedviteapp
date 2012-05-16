class Invitations::Mailer < ActionMailer::Base
  default from: "noreply@wedviteapp.com"

  def subdomain
    'invitations'
  end

  def invite(options)
    @user    = options[:user]
    @guest   = options[:guest]
    @wedding = options[:wedding]
    @url     = invitation_url @guest.token, subdomain: subdomain

    mail to: @guest.email,
         from: "#{@user.email} <noreply@wedviteapp.com>",
         subject: "Invitation to #{@wedding.title}"
  end
end
