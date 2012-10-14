class Invitations::InviteMailer < Invitations::Mailer
  def prepare options

    @wedding = options[:wedding]
    @sender  = options[:user]
    @guests  = options[:guests]

    category 'Invitations'
    substitute "-invitation_url-", urls
    substitute "-guest_name-", names

    mail to: emails,
         subject: "Invitation to #{@wedding.title}",
         template_name: 'invite'
  end
end
