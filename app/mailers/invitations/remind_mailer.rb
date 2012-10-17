class Invitations::RemindMailer < Invitations::Mailer
  def prepare options

    @wedding = options[:wedding]
    @sender  = options[:sender]
    @guest   = options[:guest]
    @url     = invitation_url @guest.token, subdomain: subdomain

    category 'Invitations'

    mail to: @guest.email,
         subject: "Invitation reminder to #{@wedding.title}",
         template_name: 'remind'
  end
end
