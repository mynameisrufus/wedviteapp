class Invitations::ThankRemindMailer < Invitations::Mailer
  def prepare options

    @wedding = options[:wedding]
    @sender  = options[:sender]
    @guest   = options[:guest]
    @url     = invitation_url @guest.token, subdomain: subdomain

    category 'Invitations'

    mail to: @guest.email,
         subject: "Thank you from #{@wedding.partners_names}",
         template_name: 'thank_remind'
  end
end
