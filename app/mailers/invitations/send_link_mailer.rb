class Invitations::SendLinkMailer < Invitations::Mailer
  def prepare options

    @wedding = options[:wedding]
    @sender  = options[:sender]
    @guest   = options[:guest]
    @url     = invitation_url @guest.token, subdomain: subdomain

    category 'Invitations'

    mail to: @guest.email,
         subject: "Details for #{@wedding.title}",
         template_name: 'send_link'
  end
end
