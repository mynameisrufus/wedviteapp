class Users::InviteCollaboratorMailer < Users::Mailer
  def prepare options

    @wedding = options[:wedding]
    @sender  = options[:requestor]
    @email   = options[:email]
    @token   = options[:token]
    @url     = collaborate_url(@token, host: host, subdomain: subdomain)

    mail to: @email,
         subject: "You are invited to collaborate on #{@wedding.title}",
         template_name: 'invite_collaborator'
  end
end
