class Users::NotifyCollaboratorMailer < Users::Mailer
  def prepare options
    @sender  = options[:requestor]
    @user    = options[:user]
    @wedding = options[:wedding]
    @url     = wedding_url(@wedding, subdomain: subdomain)

    mail to: @user.email,
         subject: "You are now collaborating on #{@wedding.title}",
         template_name: 'notify_collaborator'
  end
end
