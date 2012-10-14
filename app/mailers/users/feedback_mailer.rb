class Users::FeedbackMailer < Users::Mailer
  layout false

  def prepare options
    @user = options[:user]
    @text = options[:text]

    mail to: 'support@wedviteapp.com',
         from: "#{@user.name} <#{@user.email}>",
         subject: 'feedback',
         template_name: 'feedback'
  end
end
