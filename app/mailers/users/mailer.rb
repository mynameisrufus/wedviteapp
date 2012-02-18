class Users::Mailer < ActionMailer::Base
  default from: "noreply@wedviteapp.com"
  
  def subdomain
    'plan'
  end

  def invite_collaborator(options)
    @requestor = options[:requestor]
    @wedding   = options[:wedding]

    @email     = options[:email]
    @token     = options[:token]
    @url       = wedding_collaborate_url(@wedding, @token, host: 'wedviteapp.com', subdomain: subdomain)

    mail to: @email,
         from: "#{@requestor.name} <noreply@wedviteapp.com>",
         subject: "You are invited to collaborate on #{@wedding.name}"
  end

  def notify_collaborator(options)
    @requestor = options[:requestor]
    @wedding   = options[:wedding]

    @user      = options[:user]
    @url       = wedding_url(@wedding, host: 'wedviteapp.com',  subdomain: subdomain)

    mail to: @user.email,
         from: "#{@requestor.name} <noreply@wedviteapp.com>",
         subject: "You are now collaborating on #{@wedding.name}"
  end
end
