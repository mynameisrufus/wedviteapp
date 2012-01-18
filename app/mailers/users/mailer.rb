class Users::Mailer < ActionMailer::Base
  default from: "noreply@wedvite.net"
  
  def subdomain
    'plan'
  end

  def invite_collaborator(options)
    @requestor = options[:requestor]
    @wedding   = options[:wedding]

    @email     = options[:email]
    @token     = options[:token]
    @url       = wedding_collaborate_url(@wedding, @token, subdomain: subdomain)

    mail to: @email,
         from: "#{@requestor.name} <noreply@wedvite.net>",
         subject: "You are invited to collaborate on #{@wedding.name}"
  end

  def notify_collaborator(options)
    @requestor = options[:requestor]
    @wedding   = options[:wedding]

    @user      = options[:user]
    @url       = wedding_url(@wedding, subdomain: subdomain)

    mail to: @user.email,
         from: "#{@requestor.name} <noreply@wedvite.net>",
         subject: "You are now collaborating on #{@wedding.name}"
  end
end
