class BaseMailer < ActionMailer::Base
  layout 'mailer'

  default from: "WedVite <noreply@wedviteapp.com>"

  def subdomain
    raise "method subdomain has not been defined in child class."
  end

  def host
    hosts.fetch(Rails.env.to_sym, hosts.fetch(:development))
  end

  def hosts
    {
      production: 'wedviteapp.com',
      staging: 'wedvite.net',
      development: 'wedvite.dev'
    }
  end
end
