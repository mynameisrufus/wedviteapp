class Invitations::ThankMailer < Invitations::Mailer
  def prepare options

    @wedding = options[:wedding]
    @sender  = options[:sender]
    @guests  = options[:guests]

    category 'Invitations'
    substitute "-invitation_url-", urls
    substitute "-guest_name-", names

    mail to: emails,
         subject: "Thank you from #{@wedding.partners_names}",
         template_name: 'thank'
  end
end
