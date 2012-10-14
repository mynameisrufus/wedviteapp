class Users::InviteCollaboratorMailer < Users::Mailer
  def prepare options
    @wedding   = options[:wedding]
    @requestor = options[:requestor]
    @email     = options[:email]
    @token     = options[:token]
    @url       = collaborate_url(@token, host: host, subdomain: subdomain)

    mail to: @email,
         subject: "You are invited to collaborate on #{@wedding.name}",
         template_name: 'invite_collaborator'
  end
end
