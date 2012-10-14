class Users::Mailer < BaseMailer
  default template_path: 'users/mailer'

  def subdomain
    'plan'
  end
end
