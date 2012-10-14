# Uses the SendGrid SMTP api
# http://docs.sendgrid.com/documentation/api/smtp-api/
# http://paveltyk.github.com/sendgrid-rails/
class Invitations::Mailer < BaseMailer
  default template_path: 'invitations/mailer'

  def subdomain
    'invitations'
  end

  # SendGrid helper methods for user with the `substitute` method.
  def emails
    @guests.map do |guest|
      guest.email
    end
  end

  def urls
    @guests.map do |guest|
      invitation_url guest.token, subdomain: subdomain
    end
  end

  def names
    @guests.map do |guest|
      guest.name
    end
  end
end
