class MailPreview < MailView
  def invitations_invite
    Invitations::InviteMailer.prepare wedding: Spoof.wedding,
                                      sender: Spoof.user,
                                      guests: [Spoof.guest]
  end

  def invitations_remind
    Invitations::RemindMailer.prepare wedding: Spoof.wedding,
                                      sender: Spoof.user,
                                      guest: Spoof.guest
  end

  def invitations_thank
    Invitations::ThankMailer.prepare wedding: Spoof.wedding,
                                     sender: Spoof.user,
                                     guests: [Spoof.guest]
  end

  def invitations_thank_remind
    Invitations::ThankRemindMailer.prepare wedding: Spoof.wedding,
                                           sender: Spoof.user,
                                           guest: Spoof.guest
  end

  def invitations_send_link
    Invitations::SendLinkMailer.prepare wedding: Spoof.wedding,
                                        sender: Spoof.user,
                                        guest: Spoof.guest
  end

  def invitations_message
    Invitations::MessageMailer.prepare wedding: Spoof.wedding,
                                       message: Spoof.message,
                                       guests: [Spoof.guest],
                                       sender: Spoof.user
  end

  def invitations_reply
    Invitations::ReplyMailer.prepare reply: Spoof.reply,
                                     sender: Spoof.user,
                                     wedding: Spoof.wedding,
                                     guests: [Spoof.guest]
  end

  def users_reply
    Users::ReplyMailer.prepare reply: Spoof.reply,
                               sender: Spoof.guest,
                               wedding: Spoof.wedding,
                               users: [Spoof.user, Spoof.user]
  end

  def users_feedback
    Users::FeedbackMailer.prepare user: Spoof.user,
                                  text: Spoof.text
  end

  def users_invite_collaborator
    Users::InviteCollaboratorMailer.prepare wedding: Spoof.wedding,
                                            requestor: Spoof.user,
                                            email: Spoof.email,
                                            token: Spoof.token
  end

  def users_notify_collaborator
    Users::NotifyCollaboratorMailer.prepare wedding: Spoof.wedding,
                                            requestor: Spoof.user,
                                            user: Spoof.user
  end
end

