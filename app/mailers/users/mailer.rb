class Users::Mailer < ActionMailer::Base
  default from: "noreply@wedviteapp.com"
  
  def subdomain
    'plan'
  end

  def host
    Rails.env.production? ? 'wedviteapp.com' : 'wedvite.dev'
  end

  def invite_collaborator(options)
    @requestor = options[:requestor]
    @wedding   = options[:wedding]

    @email     = options[:email]
    @token     = options[:token]
    @url       = collaborate_url(@token, host: host, subdomain: subdomain)

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

  def feedback(options)
    @user = options[:user]
    @text = options[:text]

    mail to: 'rufuspost@gmail.com',
         from: "#{@user.email} <noreply@wedviteapp.com>",
         subject: 'Wedvite feedback'
  end
end
