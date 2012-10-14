class Invitations::RemindMailer < Invitations::Mailer
  def prepare options
    @guest = options[:guest]
  end
end
