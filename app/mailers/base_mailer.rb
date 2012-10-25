class BaseMailer < ActionMailer::Base
  layout 'mailer'

  default from: "WedVite <noreply@wedviteapp.com>"

  def subdomain
    raise "method subdomain has not been defined in child class."
  end
end
